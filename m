Return-Path: <bjking1@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AEDCDDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 09:08:29 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBJM8rLB022309
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 17:08:53 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBJM8Oc3276802
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 17:08:24 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBJM8Ot7027061
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 17:08:24 -0500
Message-ID: <458862D5.6070409@us.ibm.com>
Date: Tue, 19 Dec 2006 16:08:21 -0600
From: Brian King <bjking1@us.ibm.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] powerpc export rtas_set_slot_reset()
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<20061219190210.GE5506@austin.ibm.com>
In-Reply-To: <20061219190210.GE5506@austin.ibm.com>
Content-Type: multipart/mixed; boundary="------------010400040301090204070106"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010400040301090204070106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linas Vepstas wrote:
> Hi Paul,
> A patch that provides an export for a bug being worked on the
> IPR evice driver.

This is not the API that I tested with... Here is the patch I
was using in my test. This is not ready to apply as we are
still working issues with various hardware...

Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------010400040301090204070106
Content-Type: text/x-patch;
 name="powerpc_slot_reset_api.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="powerpc_slot_reset_api.patch"

ClRoZSBmb2xsb3dpbmcgcGF0Y2ggYWRkcyBhIGdlbmVyaWMgQVBJIHRvIGFzc2VydCBhbmQg
ZGVhc3NlcnQKUENJIHJlc2V0IHRvIGEgZGV2aWNlIG9uIGEgcFNlcmllcyBtYWNoaW5lLiBU
aGlzIGlzIG5lZWRlZCB0bwpzb2x2ZSBhbiBpc3N1ZSB3aXRoIGEgbmV3IGlwciBQQ0ktRSBh
ZGFwdGVyIHdoaWNoIGNhdXNlcyBFRUgKZXJyb3JzIHdoZW4gcnVubmluZyBCSVNULiBUaGUg
b25seSB3YXkgdG8gcmVzZXQgdGhpcyBhZGFwdGVyCndpdGhvdXQgY2F1c2luZyBhbiBFRUgg
ZXJyb3IgaXMgdG8gdXNlIFBDSSByZXNldC4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIEtpbmcg
PGJya2luZ0B1cy5pYm0uY29tPgotLS0KCiBsaW51eC0yLjYtYmpraW5nMS9hcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL3BzZXJpZXMvZWVoLmMgfCAgIDQyICsrKysrKysrKysrKysrKysrCiBs
aW51eC0yLjYtYmpraW5nMS9pbmNsdWRlL2FzbS1wb3dlcnBjL3BwYy1wY2kuaCAgICAgICAg
fCAgICAzICsKIDIgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtcHVO
IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9lZWguY35wb3dlcnBjX3Nsb3RfcmVz
ZXRfYXBpIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9lZWguYwotLS0gbGludXgt
Mi42L2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9lZWguY35wb3dlcnBjX3Nsb3Rf
cmVzZXRfYXBpCTIwMDYtMTItMTggMTU6NTg6NTYuMDAwMDAwMDAwIC0wNjAwCisrKyBsaW51
eC0yLjYtYmpraW5nMS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvZWVoLmMJMjAw
Ni0xMi0xOCAxNTo1ODo1Ny4wMDAwMDAwMDAgLTA2MDAKQEAgLTU5MSw2ICs1OTEsNDggQEAg
c3RhdGljIHZvaWQgX19ydGFzX3NldF9zbG90X3Jlc2V0KHN0cnVjdAogCW1zbGVlcCAoUENJ
X0JVU19TRVRUTEVfVElNRV9NU0VDKTsKIH0KIAorLyoqCisgKiBwY2lfc2V0X3Nsb3RfcmVz
ZXQgLSBBc3NlcnQgUENJIHJlc2V0IHRvIHRoZSBQQ0kgc2xvdAorICogQGRldjoJcGNpIGRl
dmljZSBzdHJ1Y3QKKyAqCisgKiBBZnRlciBhc3NlcnRpbmcgUENJIHJlc2V0LCB0aGUgY2Fs
bGVyIHNob3VsZCB3YWl0IGZvcgorICogMTAwIG1pbGxpc2Vjb25kcyBvciBsb25nZXIuCisg
KgorICogUmV0dXJuIHZhbHVlOgorICogCTAgaWYgc3VjY2VzcworICoqLworaW50IHBjaV9z
ZXRfc2xvdF9yZXNldChzdHJ1Y3QgcGNpX2RldiAqZGV2KQoreworCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqZG4gPSBwY2lfZGV2aWNlX3RvX09GX25vZGUoZGV2KTsKKwlzdHJ1Y3QgcGNpX2Ru
ICpwZG4gPSBQQ0lfRE4oZG4pOworCisJcnRhc19wY2lfc2xvdF9yZXNldChwZG4sIDEpOwor
CXJldHVybiAwOworfQorRVhQT1JUX1NZTUJPTF9HUEwocGNpX3NldF9zbG90X3Jlc2V0KTsK
KworLyoqCisgKiBwY2lfY2xlYXJfc2xvdF9yZXNldCAtIENsZWFyIFBDSSByZXNldCB0byB0
aGUgUENJIHNsb3QKKyAqIEBkZXY6CXBjaSBkZXZpY2Ugc3RydWN0CisgKgorICogQWZ0ZXIg
Y2xlYXJpbmcgUENJIHJlc2V0LCB0aGUgY2FsbGVyIHNob3VsZCB3YWl0IDEuOCBzZWNvbmRz
CisgKiBvciBsb25nZXIgZm9yIHRoZSBidXMgdG8gc3RhYmlsaXplIGFuZCB0aGUgZGV2aWNl
IHRvIGNvbWUKKyAqIHJlYWR5LgorICoKKyAqIFJldHVybiB2YWx1ZToKKyAqIAkwIGlmIHN1
Y2Nlc3MKKyAqKi8KK2ludCBwY2lfY2xlYXJfc2xvdF9yZXNldChzdHJ1Y3QgcGNpX2RldiAq
ZGV2KQoreworCXN0cnVjdCBkZXZpY2Vfbm9kZSAqZG4gPSBwY2lfZGV2aWNlX3RvX09GX25v
ZGUoZGV2KTsKKwlzdHJ1Y3QgcGNpX2RuICpwZG4gPSBQQ0lfRE4oZG4pOworCisJZWVoX2Ns
ZWFyX3Nsb3QgKHBkbi0+bm9kZSwgRUVIX01PREVfSVNPTEFURUQpOworCXJ0YXNfcGNpX3Ns
b3RfcmVzZXQgKHBkbiwgMCk7CisJcmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChw
Y2lfY2xlYXJfc2xvdF9yZXNldCk7CisKIGludCBydGFzX3NldF9zbG90X3Jlc2V0KHN0cnVj
dCBwY2lfZG4gKnBkbikKIHsKIAlpbnQgaSwgcmM7CmRpZmYgLXB1TiBpbmNsdWRlL2FzbS1w
b3dlcnBjL3BwYy1wY2kuaH5wb3dlcnBjX3Nsb3RfcmVzZXRfYXBpIGluY2x1ZGUvYXNtLXBv
d2VycGMvcHBjLXBjaS5oCi0tLSBsaW51eC0yLjYvaW5jbHVkZS9hc20tcG93ZXJwYy9wcGMt
cGNpLmh+cG93ZXJwY19zbG90X3Jlc2V0X2FwaQkyMDA2LTEyLTE4IDE1OjU4OjU2LjAwMDAw
MDAwMCAtMDYwMAorKysgbGludXgtMi42LWJqa2luZzEvaW5jbHVkZS9hc20tcG93ZXJwYy9w
cGMtcGNpLmgJMjAwNi0xMi0xOCAxNTo1ODo1Ny4wMDAwMDAwMDAgLTA2MDAKQEAgLTEyNCw2
ICsxMjQsOSBAQCB2b2lkIGVlaF9jbGVhcl9zbG90IChzdHJ1Y3QgZGV2aWNlX25vZGUgCiAv
KiBGaW5kIHRoZSBhc3NvY2lhdGVkICJQYXJ0aWF0aW9uYWJsZSBFbmRwb2ludCIgUEUgKi8K
IHN0cnVjdCBkZXZpY2Vfbm9kZSAqIGZpbmRfZGV2aWNlX3BlKHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqZG4pOwogCitpbnQgcGNpX3NldF9zbG90X3Jlc2V0KHN0cnVjdCBwY2lfZGV2ICpkZXYp
OworaW50IHBjaV9jbGVhcl9zbG90X3Jlc2V0KHN0cnVjdCBwY2lfZGV2ICpkZXYpOworCiAj
ZW5kaWYKIAogI2VuZGlmIC8qIF9fS0VSTkVMX18gKi8KXwo=
--------------010400040301090204070106--
