Date: Wed, 3 Oct 2001 14:22:06 -0500 (CDT)
From: Grant Erickson <erick205@umn.edu>
To: dmalek@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH]: linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c
Message-Id: <Pine.SOL.4.20.0110031419450.10159-200000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1002136926=:10159"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1002136926=:10159
Content-Type: TEXT/PLAIN; charset=US-ASCII

Please accept the attached patch to ppc4xx_setup.c. It attempts to make
the 4xx 'progress' method more consistent with other subarchitectures and,
at the very least, makes it respectful of the kernel 'quiet'
flag--important when you want a fast kernel boot.

Regards,

Grant Erickson


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE

---559023410-684387517-1002136926=:10159
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ppc4xx_setup.c.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.20.0110031422060.10159@garnet.tc.umn.edu>
Content-Description: 
Content-Disposition: attachment; filename="ppc4xx_setup.c.patch"

LS0tIGxpbnV4cHBjXzJfNF9kZXZlbC9hcmNoL3BwYy9rZXJuZWwvcHBjNHh4
X3NldHVwLmMJTW9uIE9jdCAgMSAxNDo0MDoyMiAyMDAxDQorKysgbGludXhw
cGNfMl80X2RldmVsL2FyY2gvcHBjL2tlcm5lbC9wcGM0eHhfc2V0dXAuYy5O
CVdlZCBPY3QgIDMgMTI6MDc6MTIgMjAwMQ0KQEAgLTM0NCw3ICszNDQsNyBA
QA0KIHZvaWQNCiBwcGM0eHhfcHJvZ3Jlc3MoY2hhciAqcywgdW5zaWduZWQg
c2hvcnQgaGV4KQ0KIHsNCi0gICAgICAgIHByaW50aygiPDE+LS0tLS0tLS0t
LSAgcHJvZ3Jlc3M6ICAweCV4ICVzXG4iLCBoZXgsIHMpOw0KKyAgICAgICAg
cHJpbnRrKCIlc1xuXHIiLCBzKTsNCiB9DQogDQogLyoNCg==
---559023410-684387517-1002136926=:10159--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
