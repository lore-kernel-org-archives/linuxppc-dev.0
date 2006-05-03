Return-Path: <stevewin@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0222E67B17
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 03:09:03 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k43H90f2019332
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 May 2006 13:09:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k43H90Tl250510
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 May 2006 11:09:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k43H907e000395
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 May 2006 11:09:00 -0600
Received: from d03nm125.boulder.ibm.com (d03nm125.boulder.ibm.com
	[9.17.195.151])
	by d03av03.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k43H90mx000392
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 May 2006 11:09:00 -0600
Subject: Fw: Configuring PCI w/ 44x
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF417BCEEB.CBCC9EBC-ON87257163.005DB572-85257163.005E34EB@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Wed, 3 May 2006 13:11:26 -0400
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBFBF0DFCE33E28f9e8a93df938690918c08BBFBF0DFCE33E2"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0__=08BBFBF0DFCE33E28f9e8a93df938690918c08BBFBF0DFCE33E2
Content-type: text/plain; charset=US-ASCII





Eugene Surovegin <ebs@ebshome.net> wrote on 05/02/2006 07:49:16 PM:

> On Tue, May 02, 2006 at 04:58:32PM -0400, Stephen Winiecki wrote:
> > I have a question regarding configuring PCI with 44x.  Using 2.6.17-rc3
as
> > a reference, PCI_CONFIG is defined for the 44x defconfigs, and Kconfig
is
> > not enabled to reflect/change the setting for 44x.  When I update
> > arch/ppc/Kconfig to enable configuring or not configuring PCI with 44x,
and
> > then don't configure it, the kernel won't compile:
>
> Hmm, you cannot disable PCI for 44x in the current 2.6. It's always
> enabled.
>
> If you changed Konfig to be able to do so, why are you complaining
> here? It's not enough to just change Konfig, you have to modify Ocotea
> port as well. Look for example how this is handled for 85xx.
>
> Patches are welcome.
>
> --
> Eugene
>

I was first wondering if for some reason defaulting/forcing PCI to always
be configured for 44x was intentional.  I was second reporting the fact
that if a change is made to not configure PCI for 44x, the kernel will not
compile.

Steve
--0__=08BBFBF0DFCE33E28f9e8a93df938690918c08BBFBF0DFCE33E2
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Eugene Surovegin &lt;ebs@ebshome.net&gt; wrote on 05/02/2006 07:49:16 PM:<br>
<br>
&gt; On Tue, May 02, 2006 at 04:58:32PM -0400, Stephen Winiecki wrote:<br>
&gt; &gt; I have a question regarding configuring PCI with 44x. &nbsp;Using 2.6.17-rc3 as<br>
&gt; &gt; a reference, PCI_CONFIG is defined for the 44x defconfigs, and Kconfig is<br>
&gt; &gt; not enabled to reflect/change the setting for 44x. &nbsp;When I update<br>
&gt; &gt; arch/ppc/Kconfig to enable configuring or not configuring PCI with 44x, and<br>
&gt; &gt; then don't configure it, the kernel won't compile:<br>
&gt; <br>
&gt; Hmm, you cannot disable PCI for 44x in the current 2.6. It's always <br>
&gt; enabled.<br>
&gt; <br>
&gt; If you changed Konfig to be able to do so, why are you complaining <br>
&gt; here? It's not enough to just change Konfig, you have to modify Ocotea <br>
&gt; port as well. Look for example how this is handled for 85xx.<br>
&gt; <br>
&gt; Patches are welcome.<br>
&gt; <br>
&gt; -- <br>
&gt; Eugene<br>
&gt; </tt><br>
<br>
<tt>I was first wondering if for some reason defaulting/forcing PCI to always be configured for 44x was intentional. &nbsp;I was second reporting the fact that if a change is made to not configure PCI for 44x, the kernel will not compile.</tt><br>
<br>
<tt>Steve</tt><tt><br>
</tt></body></html>
--0__=08BBFBF0DFCE33E28f9e8a93df938690918c08BBFBF0DFCE33E2--
