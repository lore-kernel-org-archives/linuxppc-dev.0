Return-Path: <m_dalmas@yahoo.com.br>
Received: from web50306.mail.re2.yahoo.com (web50306.mail.re2.yahoo.com
	[206.190.38.60]) by ozlabs.org (Postfix) with SMTP id 0EAA6DEFB1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 05:40:16 +1000 (EST)
Date: Thu, 17 Apr 2008 12:33:33 -0700 (PDT)
From: Marcelo Dalmas <m_dalmas@yahoo.com.br>
Subject: [PATCH] Fix for disabling BUG
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1506345336-1208460813=:92547"
Message-ID: <85905.92547.qm@web50306.mail.re2.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1506345336-1208460813=:92547
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

With CONFIG_BUG option disabled module_find_bug fuction (module_32.c and mo=
dule_64.c) don't compile because struct bug_entry isn't defined.


Marcelo Dalmas=0A=0A=0A      Abra sua conta no Yahoo! Mail, o =C3=BAnico se=
m limite de espa=C3=A7o para armazenamento!=0Ahttp://br.mail.yahoo.com/
--0-1506345336-1208460813=:92547
Content-Type: text/x-diff; name="powerpc-config-bug.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="powerpc-config-bug.patch"

SW5kZXg6IGFyY2gvcG93ZXJwYy9rZXJuZWwvbW9kdWxlXzY0LmMKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQotLS0gYXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1
bGVfNjQuYwkocmV2aXPDo28gNTEpCisrKyBhcmNoL3Bvd2VycGMva2VybmVs
L21vZHVsZV82NC5jCShjw7NwaWEgZGUgdHJhYmFsaG8pCkBAIC00NjcsNiAr
NDY3LDcgQEAKIAltb2R1bGVfYnVnX2NsZWFudXAobW9kKTsKIH0KIAorI2lm
ZGVmIENPTkZJR19CVUcKIHN0cnVjdCBidWdfZW50cnkgKm1vZHVsZV9maW5k
X2J1Zyh1bnNpZ25lZCBsb25nIGJ1Z2FkZHIpCiB7CiAJc3RydWN0IG1vZF9h
cmNoX3NwZWNpZmljICptb2Q7CkBAIC00ODEsMyArNDgyLDQgQEAKIAl9CiAJ
cmV0dXJuIE5VTEw7CiB9CisjZW5kaWYKSW5kZXg6IGFyY2gvcG93ZXJwYy9r
ZXJuZWwvbW9kdWxlXzMyLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
YXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1bGVfMzIuYwkocmV2aXPDo28gNTEp
CisrKyBhcmNoL3Bvd2VycGMva2VybmVsL21vZHVsZV8zMi5jCShjw7NwaWEg
ZGUgdHJhYmFsaG8pCkBAIC0zMTcsNiArMzE3LDcgQEAKIAltb2R1bGVfYnVn
X2NsZWFudXAobW9kKTsKIH0KIAorI2lmZGVmIENPTkZJR19CVUcKIHN0cnVj
dCBidWdfZW50cnkgKm1vZHVsZV9maW5kX2J1Zyh1bnNpZ25lZCBsb25nIGJ1
Z2FkZHIpCiB7CiAJc3RydWN0IG1vZF9hcmNoX3NwZWNpZmljICptb2Q7CkBA
IC0zMzEsMyArMzMyLDQgQEAKIAl9CiAJcmV0dXJuIE5VTEw7CiB9CisjZW5k
aWYK

--0-1506345336-1208460813=:92547--
