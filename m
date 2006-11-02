Return-Path: <stevewin@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6AA767B6C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 07:49:12 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA2Kn4Dr013925
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Nov 2006 15:49:04 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA2Kn4eL350872
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Nov 2006 13:49:04 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA2Kn4jq001990
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Nov 2006 13:49:04 -0700
In-Reply-To: <20061102160009.GC4928@localhost.localdomain>
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
To: Sascha Hauer <s.hauer@pengutronix.de>
Message-ID: <OF3E950149.B4C8024A-ON8725721A.006D325F-8525721A.007259AD@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Thu, 2 Nov 2006 15:49:01 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBF889DFFEB4CF8f9e8a93df938690918c08BBF889DFFEB4CF"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBF889DFFEB4CF8f9e8a93df938690918c08BBF889DFFEB4CF
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable






Sascha Hauer <s.hauer@pengutronix.de> wrote on 11/02/2006 11:00:09 AM:

> On Thu, Nov 02, 2006 at 10:32:53AM -0500, Stephen Winiecki wrote:
> >
> >    I also have a question about 750xx platforms.  I currently am
looking at
> >    adding platform code supporting IBM 750GX/CL eval boards.  Where=

would
> >    they go - as well as others like Buckeye/Chestnut if/when they m=
ove
over
> >    to /powerpc?
>
> I don't know - Lets wait for ben and others what they say about this
> approach.
> My intention with this patch is to try and motivate people to
> integrate their machines as a part of the multiplatform support, beca=
use
> it doesn't cost a thing.
> The presence of the embedded6xx entry and the entries in the director=
y
> itself makes people think (me too) that the multiplatform thing is on=
ly
> for the big irons. I think it's better to unify the two ways of platf=
orm
> support where it's possible.
>
What exactly is the intent of PPC_MULTIPLATFORM - the current desc stat=
es
"Generic desktop/server/laptop" - which doesn't exactly scream 'embedde=
d'
to me either.  I guess I saw embedded6xx as a 'catch-all' for everythin=
g
else.

I might be missing something - but when you removed EMBEDDED6xx from
powerpc/Kconfig in patch 8, and removed MPC7448HPC2 from
embedded6xx/Kconfig in patch 6 - where did you move the MPC7448HPC2 con=
fig
section to?  Is your thought that it will depend on PPC_MULTIPLATFORM n=
ow
as well?

This may be slightly off topic - but one other thing I have noticed tha=
t
the new boot wrapper script supports specific 'types' of zImage files
associated w/ 'MUTIPLATFORMS' (PSERIES, CHRP, PREP etc.) and uImage - w=
hich
is what I think the majority of 'embedded' platforms will use by defini=
ng
CONFIG_DEFAULT_UIMAGE.  For IBM boards with PIBS just 'normal' zImage E=
LF
files get loaded - I'm not sure if there should be another type
defined/supported for boards which don't fit necessarily into a
PSERIES/CHRP/PREP definition and also don't use uboot -
CONFIG_DEFAULT_ZIMAGE?

=

--0__=08BBF889DFFEB4CF8f9e8a93df938690918c08BBF889DFFEB4CF
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Sascha Hauer &lt;s.hauer@pengutronix.de&gt; wrote on 11/02/2006 =
11:00:09 AM:<br>
<br>
&gt; On Thu, Nov 02, 2006 at 10:32:53AM -0500, Stephen Winiecki wrote:<=
br>
&gt; &gt; <br>
&gt; &gt; &nbsp; &nbsp;I also have a question about 750xx platforms. &n=
bsp;I currently am looking at<br>
&gt; &gt; &nbsp; &nbsp;adding platform code supporting IBM 750GX/CL eva=
l boards. &nbsp;Where would<br>
&gt; &gt; &nbsp; &nbsp;they go - as well as others like Buckeye/Chestnu=
t if/when they move over<br>
&gt; &gt; &nbsp; &nbsp;to /powerpc?<br>
&gt; <br>
&gt; I don't know - Lets wait for ben and others what they say about th=
is<br>
&gt; approach.<br>
&gt; My intention with this patch is to try and motivate people to<br>
&gt; integrate their machines as a part of the multiplatform support, b=
ecause<br>
&gt; it doesn't cost a thing.<br>
&gt; The presence of the embedded6xx entry and the entries in the direc=
tory<br>
&gt; itself makes people think (me too) that the multiplatform thing is=
 only<br>
&gt; for the big irons. I think it's better to unify the two ways of pl=
atform<br>
&gt; support where it's possible.<br>
&gt; </tt><br>
<tt>What exactly is the intent of PPC_MULTIPLATFORM - the current desc =
states &quot;Generic desktop/server/laptop&quot; - which doesn't exactl=
y scream 'embedded' to me either. &nbsp;I guess I saw embedded6xx as a =
'catch-all' for everything else.</tt><br>
<tt><br>
I might be missing something - but when you removed EMBEDDED6xx from po=
werpc/Kconfig in patch 8, and removed MPC7448HPC2 from embedded6xx/Kcon=
fig in patch 6 - where did you move the MPC7448HPC2 config section to? =
&nbsp;Is your thought that it will depend on PPC_MULTIPLATFORM now as w=
ell?</tt><br>
<br>
<tt>This may be slightly off topic - but one other thing I have noticed=
 that the new boot wrapper script supports specific 'types' of zImage f=
iles associated w/ 'MUTIPLATFORMS' (PSERIES, CHRP, PREP etc.) and uImag=
e - which is what I think the majority of 'embedded' platforms will use=
 by defining CONFIG_DEFAULT_UIMAGE. &nbsp;For IBM boards with PIBS just=
 'normal' zImage ELF files get loaded - I'm not sure if there should be=
 another type defined/supported for boards which don't fit necessarily =
into a PSERIES/CHRP/PREP definition and also don't use uboot - CONFIG_D=
EFAULT_ZIMAGE? </tt><br>
<br>
<tt><br>
</tt></body></html>=

--0__=08BBF889DFFEB4CF8f9e8a93df938690918c08BBF889DFFEB4CF--
