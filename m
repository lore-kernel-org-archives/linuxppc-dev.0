Message-Id: <199906201323.PAA19742@wanadoo.fr>
Date: Sun, 20 Jun 1999 15:22:25 +0200
Subject: LinuxPPC1999: shared libraries and dlopen not working ?
From: "Gilles Depeyrot" <Gilles.Depeyrot@wanadoo.fr>
To: "linuxppc-user" <linuxppc-user@lists.linuxppc.org>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: multipart/mixed;
   boundary="MS_Mac_OE_3012736945_83587_MIME_Part"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> CE MESSAGE EST AU FORMAT MIME. Comme votre lecteur de courrier ne comprend pas
ce format, il se peut que tout ou partie de ce message soit illisible.

--MS_Mac_OE_3012736945_83587_MIME_Part
Content-type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

I'm having trouble getting shared libraries and dlopen to work under
LinuxPPC1999.

I have attached three small files dltest.c, lib1.c and lib2.c. lib1 and
lib2 must be built as shared libraries and dltest as an executable.

The test does the following:

/* dltest
 * test functionality of dlopen(), dlsym() and dladdr()
 *
 * dlopen()  test, w/ and w/o .init function
 * dlsym()   test, can we retrieve address from symbol
 * dladdr()  test, given an address, can we find where its from
 */

It fails on the first dlopen...

Any help appreciated,
Thanks,
Gilles

--
Gilles Depeyrot                    <mailto:Gilles.Depeyrot@wanadoo.fr>
                             <http://perso.wanadoo.fr/gilles.depeyrot>

--MS_Mac_OE_3012736945_83587_MIME_Part
Content-type: application/octet-stream; name="lib2.c";
 x-mac-creator="3F3F3F3F";
 x-mac-type="3F3F3F3F"
Content-disposition: attachment
Content-Transfer-Encoding: base64

CiNpbmNsdWRlICJzdGRpby5oIgoKI2RlZmluZSBUV0lOX0dDQ0lOSVQKI2RlZmluZSBMSUJF
TlRSWV9ERUNMKGVudHJ5KSB2b2lkIGVudHJ5KCkgX19hdHRyaWJ1dGVfXyAoKGNvbnN0cnVj
dG9yKSkKCkxJQkVOVFJZX0RFQ0woVFdJTl9MaWJFbnRyeV9saWIyKTsKCmludAloSW5zdGFu
Y2UgPSAyOwoKdm9pZApUV0lOX0xpYkVudHJ5X2xpYjIoKQp7CglwcmludGYoImxpYjIgLmlu
aXQgZnVuY3Rpb24gY2FsbGVkXG4iKTsKCXJldHVybjsKfQoKdm9pZApUV0lOX0xpYkVudHJ5
X2NvbW1vbigpCnsKCXByaW50ZigibGliMiBUV0lOX0xpYkVudHJ5X2NvbW1vbiBmdW5jdGlv
biBjYWxsZWRcbiIpOwp9Cg==

--MS_Mac_OE_3012736945_83587_MIME_Part
Content-type: application/octet-stream; name="lib1.c";
 x-mac-creator="3F3F3F3F";
 x-mac-type="3F3F3F3F"
Content-disposition: attachment
Content-Transfer-Encoding: base64

CiNpbmNsdWRlICJzdGRpby5oIgoKaW50CWhJbnN0YW5jZSA9IDE7CnZvaWQKVFdJTl9MaWJF
bnRyeV9saWIxKCkKewoJcHJpbnRmKCJsaWIxIC5pbml0IGZ1bmN0aW9uIGNhbGxlZFxuIik7
Cn0KCnZvaWQKVFdJTl9MaWJFbnRyeV9jb21tb24oKQp7CglwcmludGYoImxpYjEgVFdJTl9M
aWJFbnRyeV9jb21tb24gZnVuY3Rpb24gY2FsbGVkXG4iKTsKfQo=

--MS_Mac_OE_3012736945_83587_MIME_Part
Content-type: application/octet-stream; name="dltest.c";
 x-mac-creator="3F3F3F3F";
 x-mac-type="3F3F3F3F"
Content-disposition: attachment
Content-Transfer-Encoding: base64

CiNpbmNsdWRlICJzdGRpby5oIgojaW5jbHVkZSAiZGxmY24uaCIKCnR5cGVkZWYgdm9pZCAo
KmYpKCk7CgovKiBkbHRlc3QKICogdGVzdCBmdW5jdGlvbmFsaXR5IG9mIGRsb3BlbigpLCBk
bHN5bSgpIGFuZCBkbGFkZHIoKQogKiAKICogZGxvcGVuKCkgIHRlc3QsIHcvIGFuZCB3L28g
LmluaXQgZnVuY3Rpb24KICogZGxzeW0oKSAgIHRlc3QsIGNhbiB3ZSByZXRyaWV2ZSBhZGRy
ZXNzIGZyb20gc3ltYm9sCiAqIGRsYWRkcigpICB0ZXN0LCBnaXZlbiBhbiBhZGRyZXNzLCBj
YW4gd2UgZmluZCB3aGVyZSBpdHMgZnJvbQogKi8KCmludAptYWluKGludCBhcmdjLGNoYXIg
Kiphcmd2KQp7Cgl2b2lkICpoc287CglmICAgICBmcDsJCglpbnQgICpwOwoJRGxfaW5mbyBk
OwoKCXByaW50ZigiZGxvcGVuIHRlc3RzXG4iKTsKCWhzbyA9IGRsb3BlbigiLi9saWIxLnNv
IiwgUlRMRF9HTE9CQUwpOwkKCglpZihoc28pIHsKCQljaGFyICplbnRyeSA9ICJUV0lOX0xp
YkVudHJ5X2xpYjEiOwogCQlmcCA9IChmKSBkbHN5bShoc28sCWVudHJ5KTsKCgkJcHJpbnRm
KCJ0ZXN0MTogcGFzc2VkOiBkbG9wZW4obGlicmFyeSk6IG5vIC5pbml0IGZ1bmN0aW9uXG4i
KTsKCQkKCQlpZihmcCkgewoJCQkoKmZwKSgpOwoJCQlwcmludGYoInRlc3QgMjogcGFzc2Vk
PzogZGxzeW0oKS5pbml0IGZ1bmN0aW9uIGNhbGxlZFxuIik7CgkJfSBlbHNlCgkJCXByaW50
ZigidGVzdCAyIGZhaWxlZFxuIik7CgkJCgkJZGxjbG9zZShoc28pOwoJfSBlbHNlIAoJCXBy
aW50ZigidGVzdCAxIGZhaWxlZFxuIik7CgoKCWhzbyA9IGRsb3BlbigiLi9saWIyLnNvIixS
VExEX0dMT0JBTCk7CQoKCWlmKGhzbykgewoJCWNoYXIgKmVudHJ5ID0gIlRXSU5fTGliRW50
cnlfY29tbW9uIjsKCQlwcmludGYoInRlc3QzOiBwYXNzZWQ/OiB2ZXJpZnkgbGliMiAuaW5p
dCBmdW5jdGlvbiBjYWxsZWRcbiIpOwoKIAkJZnAgPSAoZikgZGxzeW0oaHNvLAllbnRyeSk7
CgkJCgkJaWYoZnApIHsKCQkJKCpmcCkoKTsKCQkJcHJpbnRmKCJ0ZXN0NDogcGFzc2VkPzog
dmVyaWZ5IGxpYjIgY29tbW9uIGZ1bmN0aW9uIGNhbGxlZFxuIik7CgkJfSBlbHNlIAoJCQlw
cmludGYoInRlc3QgNCBmYWlsZWRcbiIpOwoJCgkJZW50cnkgPSAiaEluc3RhbmNlIjsKIAkJ
cCA9IChpbnQgKikgZGxzeW0oaHNvLAllbnRyeSk7CgkKCQlwcmludGYoInRlc3Q1OiBwYXNz
ZWQ/OiB2ZXJpZnkgJWQgPT0gMlxuIiwqcCk7CgkJCgkJbWVtc2V0KCZkLDAsc2l6ZW9mKERs
X2luZm8pKTsKCQlkbGFkZHIocCwmZCk7CgkJcHJpbnRmKCJ0ZXN0NjogcGFzc2VkPzogdmVy
aWZ5ICVzID09IGhJbnN0YW5jZVxuIiwKCQkJZC5kbGlfc25hbWUpOwoJCXByaW50ZigiZmls
ZT0lcyBkbGFkZHI9JXAgYWRkcmVzcz0lcFxuIiwKCQkJZC5kbGlfZm5hbWUsZC5kbGlfc2Fk
ZHIscCk7CgkJCgkJZGxjbG9zZShoc28pOwoJfQoJcmV0dXJuIDA7Cn0K

--MS_Mac_OE_3012736945_83587_MIME_Part--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
