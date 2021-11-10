@[if msg.kind == msg.KIND_SERVICE]@
@{from dronecan_dsdlc_helpers import *}@
#pragma once
#include <@(msg_header_name_request(msg))>
#include <@(msg_header_name_response(msg))>

#define @(underscored_name(msg).upper())_ID @(msg.default_dtid)
#define @(underscored_name(msg).upper())_SIGNATURE @('(0x%08XULL)' % (msg.get_data_type_signature(),))
@[end if]@
