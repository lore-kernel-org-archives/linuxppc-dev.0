Return-Path: <Jason.Work@ca.schneider-electric.com>
Received: from ns1.squared.com (ns1.squared.com [12.47.110.6])
	by ozlabs.org (Postfix) with ESMTP id EE7DCDDF54
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 04:10:33 +1000 (EST)
Received: from CVGNG01.CIS.SQUARED.COM (cvgng01.cis.squared.com [157.198.5.45])
	by ns1.squared.com (AIX5.1/8.11.6p2/8.11.0) with ESMTP id l3QHrEH176716
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Apr 2007 13:53:14 -0400
To: linuxppc-embedded@ozlabs.org
Subject: Re: fads823 ethernet interface does (seams) not send data
MIME-Version: 1.0
From: Jason.Work@ca.schneider-electric.com
Message-ID: <OF3EE1B7CC.6CCB10A0-ON882572C9.00620D99-882572C9.00623198@US.Schneider-Electric.com>
Date: Thu, 26 Apr 2007 10:52:32 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 00623116882572C9_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00623116882572C9_=
Content-Type: text/plain; charset="US-ASCII"

"In your case, you'll notice that the PA7/ETHTCK from the motherboard is
really connected to PA5/ETHTCK on the daughtercard.  I have seen
Ethernet working on the MPC823FADS board, so I know it CAN be done."

I've got half-duplex communication over SNI working but now I want to move 
to full-duplex.  My changes are not working.  Have you seen this done 
successfully?
--=_alternative 00623116882572C9_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=3><tt>&quot;In your case, you'll notice that the PA7/ETHTCK
from the motherboard is<br>
really connected to PA5/ETHTCK on the daughtercard. &nbsp;I have seen<br>
Ethernet working on the MPC823FADS board, so I know it CAN be done.&quot;</tt></font>
<br>
<br><font size=3><tt>I've got half-duplex communication over SNI working
but now I want to move to full-duplex. &nbsp;My changes are not working.
&nbsp;Have you seen this done successfully?</tt></font>
--=_alternative 00623116882572C9_=--
