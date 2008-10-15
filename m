Return-Path: <muvarov@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id EB510DDFA9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 19:46:26 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1961945fga.39
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 01:46:25 -0700 (PDT)
Message-ID: <572af9170810150146p58c599fvabb41338ffd4e033@mail.gmail.com>
Date: Wed, 15 Oct 2008 12:46:24 +0400
From: "Maxim Uvarov" <muvarov@gmail.com>
To: "Simon Horman" <horms@verge.net.au>
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
In-Reply-To: <20081015031818.GC27243@verge.net.au>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8470_11336369.1224060384834"
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
	<20081015031818.GC27243@verge.net.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_8470_11336369.1224060384834
Content-Type: multipart/alternative;
	boundary="----=_Part_8471_21552431.1224060384834"

------=_Part_8471_21552431.1224060384834
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch corrected. ( git_kexec_powerpc_v2.patch is attached.)

I tested it on ppc64 pasemi electra board. Both kexec -l and kexec -p works.

Maxim.



2008/10/15 Simon Horman <horms@verge.net.au>

> On Tue, Oct 14, 2008 at 07:11:19PM +0400, Maxim Uvarov wrote:
> > Hello all,
> >
> > As you all know it is not easy to count exact value of memory ranges from
> > device tree on powerpc.
> > It very depends on how dts file was written. What do you think about
> really
> > dynamic allocation buffers
> > for this buffers?
>
> Conceptually I have no objections to the change,
> though I would like to get some review from ppc people.
> (linuxppc-dev@ozlabs.org CCed)
>
> > Patch is attached.
>
> This patch doesn't seem to compile for me.
>
> # powerpc64-unknown-linux-gnu-gcc --version
> powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1
> Copyright (C) 2006 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> #make
> [snip]
> kexec/arch/ppc64/kexec-ppc64.c:100: warning: function declaration isn't a
> prototype
> kexec/arch/ppc64/kexec-ppc64.c: In function 'realloc_memory_ranges':
> kexec/arch/ppc64/kexec-ppc64.c:107: warning: passing argument 1 of
> 'realloc' makes pointer from integer without a cast
> kexec/arch/ppc64/kexec-ppc64.c:107: error: too few arguments to function
> 'realloc'
> kexec/arch/ppc64/kexec-ppc64.c:102: warning: unused variable 'tmp'
>
> --
> Simon Horman
>  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
>  H: www.vergenet.net/~horms/ <http://www.vergenet.net/%7Ehorms/>
>   W: www.valinux.co.jp/en
>
>


-- 
Best regards,
Maxim Uvarov

------=_Part_8471_21552431.1224060384834
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch corrected. ( git_kexec_powerpc_v2.patch is attached.)<br><br>I tested it on ppc64 pasemi electra board. Both kexec -l and kexec -p works.<br><br>Maxim.<br><br><br><br><div class="gmail_quote">2008/10/15 Simon Horman <span dir="ltr">&lt;<a href="mailto:horms@verge.net.au">horms@verge.net.au</a>&gt;</span><br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">On Tue, Oct 14, 2008 at 07:11:19PM +0400, Maxim Uvarov wrote:<br>
&gt; Hello all,<br>
&gt;<br>
&gt; As you all know it is not easy to count exact value of memory ranges from<br>
&gt; device tree on powerpc.<br>
&gt; It very depends on how dts file was written. What do you think about really<br>
&gt; dynamic allocation buffers<br>
&gt; for this buffers?<br>
<br>
</div>Conceptually I have no objections to the change,<br>
though I would like to get some review from ppc people.<br>
(<a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a> CCed)<br>
<br>
&gt; Patch is attached.<br>
<br>
This patch doesn&#39;t seem to compile for me.<br>
<br>
# powerpc64-unknown-linux-gnu-gcc --version<br>
powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1<br>
Copyright (C) 2006 Free Software Foundation, Inc.<br>
This is free software; see the source for copying conditions. &nbsp;There is NO<br>
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.<br>
<br>
#make<br>
[snip]<br>
kexec/arch/ppc64/kexec-ppc64.c:100: warning: function declaration isn&#39;t a<br>
prototype<br>
kexec/arch/ppc64/kexec-ppc64.c: In function &#39;realloc_memory_ranges&#39;:<br>
kexec/arch/ppc64/kexec-ppc64.c:107: warning: passing argument 1 of &#39;realloc&#39; makes pointer from integer without a cast<br>
kexec/arch/ppc64/kexec-ppc64.c:107: error: too few arguments to function &#39;realloc&#39;<br>
kexec/arch/ppc64/kexec-ppc64.c:102: warning: unused variable &#39;tmp&#39;<br>
<font color="#888888"><br>
--<br>
Simon Horman<br>
 &nbsp;VA Linux Systems Japan K.K., Sydney, Australia Satellite Office<br>
 &nbsp;H: <a href="http://www.vergenet.net/%7Ehorms/" target="_blank">www.vergenet.net/~horms/</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; W: <a href="http://www.valinux.co.jp/en" target="_blank">www.valinux.co.jp/en</a><br>
<br>
</font></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Maxim Uvarov<br>

------=_Part_8471_21552431.1224060384834--

------=_Part_8470_11336369.1224060384834
Content-Type: text/x-patch; name=git_kexec_powerpc_v2.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmbprn880
Content-Disposition: attachment; filename=git_kexec_powerpc_v2.patch

ZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvcHBjNjQva2V4ZWMtcHBjNjQuYyBiL2tleGVjL2FyY2gv
cHBjNjQva2V4ZWMtcHBjNjQuYwppbmRleCAwNjlhOWZjLi4wYWQ0MGZhIDEwMDY0NAotLS0gYS9r
ZXhlYy9hcmNoL3BwYzY0L2tleGVjLXBwYzY0LmMKKysrIGIva2V4ZWMvYXJjaC9wcGM2NC9rZXhl
Yy1wcGM2NC5jCkBAIC05Niw5NiArOTYsNDYgQEAgZXJyMToKIAogfQogCi1zdGF0aWMgaW50IGNv
dW50X2R5bl9yZWNvbmZfbWVtb3J5X3Jhbmdlcyh2b2lkKQorc3RhdGljIGludCByZWFsbG9jX21l
bW9yeV9yYW5nZXMoKQogewotCWNoYXIgZGV2aWNlX3RyZWVbXSA9ICIvcHJvYy9kZXZpY2UtdHJl
ZS8iOwotCWNoYXIgZm5hbWVbMTI4XTsKLQljaGFyIGJ1ZlszMl07Ci0JRklMRSAqZmlsZTsKLQot
CXN0cmNweShmbmFtZSwgZGV2aWNlX3RyZWUpOwotCXN0cmNhdChmbmFtZSwgImlibSxkeW5hbWlj
LXJlY29uZmlndXJhdGlvbi1tZW1vcnkvaWJtLGxtYi1zaXplIik7Ci0JaWYgKChmaWxlID0gZm9w
ZW4oZm5hbWUsICJyIikpID09IE5VTEwpIHsKLQkJcGVycm9yKGZuYW1lKTsKLQkJcmV0dXJuIC0x
OwotCX0KKwlzaXplX3QgbWVtb3J5X3JhbmdlX2xlbjsKIAotCWlmIChmcmVhZChidWYsIDEsIDgs
IGZpbGUpIDwgMCkgewotCQlwZXJyb3IoZm5hbWUpOwotCQlmY2xvc2UoZmlsZSk7Ci0JCXJldHVy
biAtMTsKLQl9Ci0KLQlsbWJfc2l6ZSA9ICgodWludDY0X3QgKilidWYpWzBdOwotCWZjbG9zZShm
aWxlKTsKKwltYXhfbWVtb3J5X3JhbmdlcysrOworCW1lbW9yeV9yYW5nZV9sZW4gPSBzaXplb2Yo
c3RydWN0IG1lbW9yeV9yYW5nZSkgKiBtYXhfbWVtb3J5X3JhbmdlczsKIAotCS8qIEdldCBudW1i
ZXIgb2YgbG1icyBmcm9tIGlibSxkeW5hbWljLW1lbW9yeSAqLwotCXN0cmNweShmbmFtZSwgZGV2
aWNlX3RyZWUpOwotCXN0cmNhdChmbmFtZSwgImlibSxkeW5hbWljLXJlY29uZmlndXJhdGlvbi1t
ZW1vcnkvaWJtLGR5bmFtaWMtbWVtb3J5Iik7Ci0JaWYgKChmaWxlID0gZm9wZW4oZm5hbWUsICJy
IikpID09IE5VTEwpIHsKLQkJcGVycm9yKGZuYW1lKTsKLQkJcmV0dXJuIC0xOwotCX0KLQkvKgot
CSAqIGZpcnN0IDQgYnl0ZXMgcHJvdmlkZSBudW1iZXIgb2YgZW50cmllcyhsbWJzKQotCSAqLwot
CWlmIChmcmVhZChidWYsIDEsIDQsIGZpbGUpIDwgMCkgewotCQlwZXJyb3IoZm5hbWUpOwotCQlm
Y2xvc2UoZmlsZSk7Ci0JCXJldHVybiAtMTsKLQl9Ci0JbnVtX29mX2xtYnMgPSAoKHVuc2lnbmVk
IGludCAqKWJ1ZilbMF07Ci0JbWF4X21lbW9yeV9yYW5nZXMgKz0gbnVtX29mX2xtYnM7Ci0JZmNs
b3NlKGZpbGUpOworCW1lbW9yeV9yYW5nZSA9IChzdHJ1Y3QgbWVtb3J5X3JhbmdlICopIHJlYWxs
b2MobWVtb3J5X3JhbmdlLCBtZW1vcnlfcmFuZ2VfbGVuKTsKKwlpZiAoIW1lbW9yeV9yYW5nZSkK
KwkJZ290byBlcnI7CiAKLQlyZXR1cm4gMDsKLX0KKwliYXNlX21lbW9yeV9yYW5nZSA9IChzdHJ1
Y3QgbWVtb3J5X3JhbmdlICopIHJlYWxsb2MobWVtb3J5X3JhbmdlLCBtZW1vcnlfcmFuZ2VfbGVu
KTsKKwlpZiAoIWJhc2VfbWVtb3J5X3JhbmdlKQorCQlnb3RvIGVycjsKIAotLyoKLSAqIENvdW50
IHRoZSBtZW1vcnkgbm9kZXMgdW5kZXIgL3Byb2MvZGV2aWNlLXRyZWUgYW5kIHBvcHVsYXRlIHRo
ZQotICogbWF4X21lbW9yeV9yYW5nZXMgdmFyaWFibGUuIFRoaXMgdmFyaWFibGUgcmVwbGFjZXMg
TUFYX01FTU9SWV9SQU5HRVMKLSAqIG1hY3JvIHVzZWQgZWFybGllci4KLSAqLwotc3RhdGljIGlu
dCBjb3VudF9tZW1vcnlfcmFuZ2VzKHZvaWQpCi17Ci0JY2hhciBkZXZpY2VfdHJlZVsyNTZdID0g
Ii9wcm9jL2RldmljZS10cmVlLyI7Ci0Jc3RydWN0IGRpcmVudCAqZGVudHJ5OwotCURJUiAqZGly
OworCWV4Y2x1ZGVfcmFuZ2UgPSAoc3RydWN0IG1lbW9yeV9yYW5nZSAqKSByZWFsbG9jKGV4Y2x1
ZGVfcmFuZ2UsIG1lbW9yeV9yYW5nZV9sZW4pOworCWlmICghZXhjbHVkZV9yYW5nZSkKKwkJZ290
byBlcnI7CiAKLQlpZiAoKGRpciA9IG9wZW5kaXIoZGV2aWNlX3RyZWUpKSA9PSBOVUxMKSB7Ci0J
CXBlcnJvcihkZXZpY2VfdHJlZSk7Ci0JCXJldHVybiAtMTsKLQl9CisJdXNhYmxlbWVtX3JnbnMu
cmFuZ2VzID0gKHN0cnVjdCBtZW1vcnlfcmFuZ2UgKikKKwkJCQlyZWFsbG9jKHVzYWJsZW1lbV9y
Z25zLnJhbmdlcywgbWVtb3J5X3JhbmdlX2xlbik7CisJaWYgKCEodXNhYmxlbWVtX3JnbnMucmFu
Z2VzKSkKKwkJZ290byBlcnI7CiAKLQl3aGlsZSAoKGRlbnRyeSA9IHJlYWRkaXIoZGlyKSkgIT0g
TlVMTCkgewotCQlpZiAoIXN0cm5jbXAoZGVudHJ5LT5kX25hbWUsCi0JCQkJImlibSxkeW5hbWlj
LXJlY29uZmlndXJhdGlvbi1tZW1vcnkiLCAzNSkpewotCQkJaWYgKGNvdW50X2R5bl9yZWNvbmZf
bWVtb3J5X3JhbmdlcygpICE9IDApCi0JCQkJcmV0dXJuIC0xOwotCQkJY29udGludWU7Ci0JCX0K
KwlyZXR1cm4gMDsKIAotCQlpZiAoc3RybmNtcChkZW50cnktPmRfbmFtZSwgIm1lbW9yeUAiLCA3
KSAmJgotCQkJc3RyY21wKGRlbnRyeS0+ZF9uYW1lLCAibWVtb3J5IikgJiYKLQkJCXN0cm5jbXAo
ZGVudHJ5LT5kX25hbWUsICJwY2lAIiwgNCkpCi0JCQljb250aW51ZTsKLQkJbWF4X21lbW9yeV9y
YW5nZXMrKzsKLQl9Ci0JLyogbmVlZCB0byBhZGQgZXh0cmEgcmVnaW9uIGZvciByZXRhaW5lZCBp
bml0cmQgKi8KLQlpZiAocmV1c2VfaW5pdHJkKSB7Ci0JCW1heF9tZW1vcnlfcmFuZ2VzKys7Ci0J
fQorZXJyOgorCWZwcmludGYoc3RkZXJyLCAibWVtb3J5IHJhbmdlIHN0cnVjdHVyZSByZS1hbGxv
Y2F0aW9uIGZhaWx1cmVcbiIpOworCXJldHVybiAtMTsKK30KIAotCWNsb3NlZGlyKGRpcik7CiAK
LQlyZXR1cm4gMDsKLX0KIHN0YXRpYyB2b2lkIGFkZF9iYXNlX21lbW9yeV9yYW5nZSh1aW50NjRf
dCBzdGFydCwgdWludDY0X3QgZW5kKQogewogCWJhc2VfbWVtb3J5X3JhbmdlW25yX21lbW9yeV9y
YW5nZXNdLnN0YXJ0ID0gc3RhcnQ7CiAJYmFzZV9tZW1vcnlfcmFuZ2VbbnJfbWVtb3J5X3Jhbmdl
c10uZW5kICA9IGVuZDsKIAliYXNlX21lbW9yeV9yYW5nZVtucl9tZW1vcnlfcmFuZ2VzXS50eXBl
ID0gUkFOR0VfUkFNOwogCW5yX21lbW9yeV9yYW5nZXMrKzsKKwlpZiAobnJfbWVtb3J5X3Jhbmdl
cyA+PSBtYXhfbWVtb3J5X3JhbmdlcykgCisJCXJlYWxsb2NfbWVtb3J5X3JhbmdlcygpOyAKIAog
CWRiZ3ByaW50ZigiJTAxNmxseC0lMDE2bGx4IDogJXhcbiIsCiAJCWJhc2VfbWVtb3J5X3Jhbmdl
W25yX21lbW9yeV9yYW5nZXMtMV0uc3RhcnQsCkBAIC0zMDAsOCArMjUwLDggQEAgc3RhdGljIGlu
dCBnZXRfYmFzZV9yYW5nZXModm9pZCkKIAkJCQlyZXR1cm4gLTE7CiAJCQl9CiAJCQlpZiAobnJf
bWVtb3J5X3JhbmdlcyA+PSBtYXhfbWVtb3J5X3JhbmdlcykgewotCQkJCWZjbG9zZShmaWxlKTsK
LQkJCQlicmVhazsKKwkJCQlpZiAocmVhbGxvY19tZW1vcnlfcmFuZ2VzKCkgPCAwKQorCQkJCQli
cmVhazsKIAkJCX0KIAkJCXN0YXJ0ID0gKCh1aW50NjRfdCAqKWJ1ZilbMF07CiAJCQllbmQgPSBz
dGFydCArICgodWludDY0X3QgKilidWYpWzFdOwpAQCAtMzk2LDYgKzM0Niw4IEBAIHN0YXRpYyBp
bnQgZ2V0X2RldnRyZWVfZGV0YWlscyh1bnNpZ25lZCBsb25nIGtleGVjX2ZsYWdzKQogCQkJZXhj
bHVkZV9yYW5nZVtpXS5zdGFydCA9IDB4MFVMOwogCQkJZXhjbHVkZV9yYW5nZVtpXS5lbmQgPSBr
ZXJuZWxfZW5kOwogCQkJaSsrOworCQkJaWYgKGkgPj0gbWF4X21lbW9yeV9yYW5nZXMpCisJCQkJ
cmVhbGxvY19tZW1vcnlfcmFuZ2VzKCk7CiAKIAkJCWlmIChrZXhlY19mbGFncyAmIEtFWEVDX09O
X0NSQVNIKSB7CiAJCQkJbWVtc2V0KGZuYW1lLCAwLCBzaXplb2YoZm5hbWUpKTsKQEAgLTQ3MCw2
ICs0MjIsOCBAQCBzdGF0aWMgaW50IGdldF9kZXZ0cmVlX2RldGFpbHModW5zaWduZWQgbG9uZyBr
ZXhlY19mbGFncykKIAkJCWV4Y2x1ZGVfcmFuZ2VbaV0uc3RhcnQgPSBodGFiX2Jhc2U7CiAJCQll
eGNsdWRlX3JhbmdlW2ldLmVuZCA9IGh0YWJfYmFzZSArIGh0YWJfc2l6ZTsKIAkJCWkrKzsKKwkJ
CWlmIChpID49IG1heF9tZW1vcnlfcmFuZ2VzKQorCQkJCXJlYWxsb2NfbWVtb3J5X3Jhbmdlcygp
OwogCiAJCQkvKiByZXNlcnZlIHRoZSBpbml0cmRfc3RhcnQgYW5kIGVuZCBsb2NhdGlvbnMuICov
CiAJCQlpZiAocmV1c2VfaW5pdHJkKSB7CkBAIC01NDUsNiArNDk5LDggQEAgc3RhdGljIGludCBn
ZXRfZGV2dHJlZV9kZXRhaWxzKHVuc2lnbmVkIGxvbmcga2V4ZWNfZmxhZ3MpCiAJCQlleGNsdWRl
X3JhbmdlW2ldLnN0YXJ0ID0gcnRhc19iYXNlOwogCQkJZXhjbHVkZV9yYW5nZVtpXS5lbmQgPSBy
dGFzX2Jhc2UgKyBydGFzX3NpemU7CiAJCQlpKys7CisJCQlpZiAoaSA+PSBtYXhfbWVtb3J5X3Jh
bmdlcykKKwkJCQlyZWFsbG9jX21lbW9yeV9yYW5nZXMoKTsKIAkJCWlmIChrZXhlY19mbGFncyAm
IEtFWEVDX09OX0NSQVNIKQogCQkJCWFkZF91c2FibGVfbWVtX3JnbnMocnRhc19iYXNlLCBydGFz
X3NpemUpOwogCQl9IC8qIHJ0YXMgKi8KQEAgLTc0MCw5ICs2OTYsMTAgQEAgb3V0OgogLyogUmV0
dXJuIGEgbGlzdCBvZiB2YWxpZCBtZW1vcnkgcmFuZ2VzICovCiBpbnQgZ2V0X21lbW9yeV9yYW5n
ZXMoc3RydWN0IG1lbW9yeV9yYW5nZSAqKnJhbmdlLCBpbnQgKnJhbmdlcywKIAkJCXVuc2lnbmVk
IGxvbmcga2V4ZWNfZmxhZ3MpCi17Ci0JaWYgKGNvdW50X21lbW9yeV9yYW5nZXMoKSkKLQkJcmV0
dXJuIC0xOworewkKKyAgICAgICAgLyogYWxsb2NhdGUgbWVtb3J5X3JhbmdlIGR5bmFtaWNhbGx5
ICovCisgICAgICAgIG1heF9tZW1vcnlfcmFuZ2VzID0gMTsKKwogCWlmIChhbGxvY19tZW1vcnlf
cmFuZ2VzKCkpCiAJCXJldHVybiAtMTsKIAlpZiAoc2V0dXBfbWVtb3J5X3JhbmdlcyhrZXhlY19m
bGFncykpCg==
------=_Part_8470_11336369.1224060384834--
