Message-ID: <3CE99C1D.5C160E65@ixiacom.com>
Date: Mon, 20 May 2002 18:00:13 -0700
From: Dan Kegel <dkegel@ixiacom.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	dank@kegel.com
Subject: Re: bitkeeper, the 2_4_devel tree, and branches
References: <3CE99643.B7188518@ixiacom.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As a followup:

I saved
http://ppc.bkbits.net:8080/linuxppc_2_4_devel/ChangeSet@-1y?nav=index.html
as text in netscape, then ran it through
    grep -i ' 1\.[0-9]* .*Merge to 2.4'
to figure out which revisions with only one dot in
their changeset name roughly corresponded to Linus kernels.
Result:

  10 weeks  paulus      1.909    merge to 2.4.19-pre3 pulled from
linux_2_4 tree
  4 months  paulus      1.827    merge to 2.4.18-pre7
  5 months  paulus      1.796    merge to 2.4.18-pre2
  6 months  paulus      1.749    merge to 2.4.17-pre6
  7 months  paulus      1.654    merge to 2.4.15-pre5
  7 months  paulus      1.625    merge to 2.4.15-pre3
  7 months  trini       1.611    Merge to 2.4.15-pre1.
  9 months  paulus      1.468    merge to 2.4.10-pre11
  9 months  paulus      1.464    merge to 2.4.10-pre10
  9 months  paulus      1.456    merge to 2.4.10-pre9
  9 months  paulus      1.442    merge to 2.4.10-pre8
  9 months  paulus      1.440    new version of radeon driver, merge to
2.4.10-pre7
  9 months  paulus      1.439    merge to 2.4.10-pre7
  9 months  paulus      1.380    merge to 2.4.10-pre1
 10 months  paulus      1.294    merge to 2.4.9-pre1
 10 months  trini       1.257    Merge to 2.4.8-pre1
 11 months  paulus      1.209    merge to 2.4.7-pre5

This might be useful info for someone using the main branch
of linux_2_4 and who needs a bugfix that was introduced
with a particular Linus kernel, I suppose.
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
