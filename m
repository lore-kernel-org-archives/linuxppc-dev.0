Return-Path: <LukeBrowning@us.ibm.com>
In-Reply-To: <20060715220757.GA31511@krispykreme>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
MIME-Version: 1.0
Message-ID: <OF59BDE546.E01BC166-ON832571AD.007DE61B-832571AD.007E9CB7@us.ibm.com>
From: Luke Browning <LukeBrowning@us.ibm.com>
Date: Sun, 16 Jul 2006 21:02:57 -0200
Content-Type: multipart/alternative;
	boundary="=_alternative 007E9CB6832571AD_="
Cc: linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bryan S Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Christopher Yeoh <cyeoh@samba.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 007E9CB6832571AD_=
Content-Type: text/plain; charset="US-ASCII"

linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 
07/15/2006 07:07:58 PM:

> 
> > Not sure I follow you. I would expect the PURR value to be restored 
after
> > a context switch, even if we continue on a different physical CPU.
> > 
> > The idea behind monitoring both PURR and timebase is that the 
difference
> > between the two tells you how long the partition was suspended during
> > the hcall.
> 
> Sounds good, last time I looked at the patch I thought it was gathering
> the PURR only. That on its own would make for some confusing results.
>

It would be more efficient to have a separate trace log for PHYP 
dispatches as 
there are many more hypervisor calls than PHYP dispatches.  I believe PHYP 
provides
a trace records for dispatches, which could be seperately written.  Perf 
tools can 
assemble the information from multiple records.  It would be nice to have 
processor
specific time function that reads either PURR or TB based on the platform.

Luke


--=_alternative 007E9CB6832571AD_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org
wrote on 07/15/2006 07:07:58 PM:<br>
<br>
&gt; &nbsp;<br>
&gt; &gt; Not sure I follow you. I would expect the PURR value to be restored
after<br>
&gt; &gt; a context switch, even if we continue on a different physical
CPU.<br>
&gt; &gt; <br>
&gt; &gt; The idea behind monitoring both PURR and timebase is that the
difference<br>
&gt; &gt; between the two tells you how long the partition was suspended
during<br>
&gt; &gt; the hcall.<br>
&gt; <br>
&gt; Sounds good, last time I looked at the patch I thought it was gathering<br>
&gt; the PURR only. That on its own would make for some confusing results.<br>
&gt;</font></tt>
<br>
<br><tt><font size=2>It would be more efficient to have a separate trace
log for PHYP dispatches as </font></tt>
<br><tt><font size=2>there are many more hypervisor calls than PHYP dispatches.
&nbsp;I believe PHYP provides</font></tt>
<br><tt><font size=2>a trace records for dispatches, which could be seperately
written. &nbsp;Perf tools can </font></tt>
<br><tt><font size=2>assemble the information from multiple records. &nbsp;It
would be nice to have processor</font></tt>
<br><tt><font size=2>specific time function that reads either PURR or TB
based on the platform.</font></tt>
<br>
<br><tt><font size=2>Luke</font></tt>
<br><tt><font size=2><br>
</font></tt>
--=_alternative 007E9CB6832571AD_=--
