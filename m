Date: Sun, 9 Feb 2003 21:30:31 +0000
From: Magnus Damm <damm@opensource.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: pmac: input layer as module and usb keyboard
Message-Id: <20030209213031.2b67933e.damm@opensource.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__9_Feb_2003_21:30:31_+0000_101fc900"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart_Sun__9_Feb_2003_21:30:31_+0000_101fc900
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

This patch makes it possible to use a usb keyboard with a kernel that has the
input layer compiled as a module.

Please apply.

thanks /

magnus



--Multipart_Sun__9_Feb_2003_21:30:31_+0000_101fc900
Content-Type: application/octet-stream;
 name="linux-2.4.20-pmac_input_module.patch"
Content-Disposition: attachment;
 filename="linux-2.4.20-pmac_input_module.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNC4yMC9hcmNoL3BwYy9wbGF0Zm9ybXMvcG1hY19zZXR1cC5jCTIwMDItMTEt
MjggMjM6NTM6MTEuMDAwMDAwMDAwICswMDAwCisrKyBsaW51eC0yLjQuMjAtcG1hY19pbnB1dF9t
b2R1bGUvYXJjaC9wcGMvcGxhdGZvcm1zL3BtYWNfc2V0dXAuYwkyMDAzLTAyLTA5IDE0OjQ4OjU1
LjAwMDAwMDAwMCArMDAwMApAQCAtODUxLDcgKzg1MSw3IEBACiBzZWxlY3RfYWRiX2tleWJvYXJk
KHZvaWQpCiB7CiAjaWZkZWYgQ09ORklHX1ZUCi0jaWZkZWYgQ09ORklHX0lOUFVUCisjaWYgZGVm
aW5lZChDT05GSUdfSU5QVVQpIHx8IGRlZmluZWQoQ09ORklHX0lOUFVUX01PRFVMRSkKIAlwcGNf
bWQua2JkX2luaXRfaHcgICAgICAgPSBtYWNfaGlkX2luaXRfaHc7CiAJcHBjX21kLmtiZF90cmFu
c2xhdGUgICAgID0gbWFjX2hpZF9rYmRfdHJhbnNsYXRlOwogCXBwY19tZC5rYmRfdW5leHBlY3Rl
ZF91cCA9IG1hY19oaWRfa2JkX3VuZXhwZWN0ZWRfdXA7Cg==

--Multipart_Sun__9_Feb_2003_21:30:31_+0000_101fc900--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
