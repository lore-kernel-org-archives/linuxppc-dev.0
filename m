Return-Path: <kjoutwater@raytheon.com>
Received: from tus-mailout1.raytheon.com (tus-mailout1.raytheon.com
	[199.46.245.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tus-mailout1.raytheon.com",
	Issuer "Entrust.net Secure Server Certification Authority" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id B68C467B77
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 09:08:46 +1000 (EST)
Received: from dmoutt00.directory.ray.com (dmoutt00.directory.ray.com
	[147.25.154.125])
	by tus-mailout1.raytheon.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id
	k8EN8cvK022853
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Sep 2006 23:08:39 GMT
Received: from dmsmtpt00.directory.ray.com (dmsmtpt00.directory.ray.com
	[147.25.154.118])
	by dmoutt00.directory.ray.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	k8EN8gPq017979
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 23:08:43 GMT
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by dmsmtpt00.directory.ray.com (8.12.11/8.12.11) with ESMTP id
	k8EN8f6Q007419
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 23:08:41 GMT
In-Reply-To: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA6FA@XSJ-EXCHVS1.xlnx.xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: RE: Ethernet driver for Linux kernel 2.6 running on ML403
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF810D9D6F.E86CECF8-ON072571E9.007E8B00-072571E9.007F1AEC@mck.us.ray.com>
Date: Thu, 14 Sep 2006 16:08:37 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"John Bonesio" <john.bonesio@xilinx.com> wrote on 09/14/2006 10:52:16 AM:
<snip>
> 
> I don't think that there are any "version" registers in the Xilinx 
> IP cores that a driver could check to determine compatibility.  That
> would be very cheap to implement in hardware and you could then
> develop more universal drivers.
> 
> [John]
> We've examined doing this in the past, and gotten some push back due to
> the use of bram or other resources. Conceptually, it's a great idea, I
> just don't know if this is likely to happen any time soon.
> 

John,
I thinking in terms of something like a 32 bit register
(i.e. like a processor's PVR register) that has a hard-coded magic number
which a driver can read and decode to determine driver compatibility.
That does not sound resource-intensive given the size FPGAs we are talking
about.  Probably don't even need 32 bits.

Keith
