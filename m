Return-Path: <LukeBrowning@us.ibm.com>
In-Reply-To: <20060715153053.GK31081@krispykreme>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
MIME-Version: 1.0
Message-ID: <OF1AE83383.D9BC15A2-ON832571AE.000B2250-832571AE.000B3E67@us.ibm.com>
From: Luke Browning <LukeBrowning@us.ibm.com>
Date: Mon, 17 Jul 2006 00:02:49 -0200
Content-Type: multipart/alternative;
	boundary="=_alternative 000B3E65832571AE_="
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
--=_alternative 000B3E65832571AE_=
Content-Type: text/plain; charset="US-ASCII"

linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 
07/15/2006 12:30:54 PM:

> 
> > What happened to the question whether to use PURR values for also 
measuring
> > cycles spent executing the hcall as opposed to cycles that passed 
before
> > the hcall returns. Did that turn out not giving extra information 
after all
> > or was there a different reason to drop that idea?
> 
> You have to be careful with PURR since it may be context switched
> between partitions.
> 

That shouldn't be an issue as the PURR is supposed to be virtualized by 
PHYP at 
the virtual processor level.

Luke
--=_alternative 000B3E65832571AE_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><tt><font size=2>linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org
wrote on 07/15/2006 12:30:54 PM:<br>
<br>
&gt; &nbsp;<br>
&gt; &gt; What happened to the question whether to use PURR values for
also measuring<br>
&gt; &gt; cycles spent executing the hcall as opposed to cycles that passed
before<br>
&gt; &gt; the hcall returns. Did that turn out not giving extra information
after all<br>
&gt; &gt; or was there a different reason to drop that idea?<br>
&gt; <br>
&gt; You have to be careful with PURR since it may be context switched<br>
&gt; between partitions.<br>
&gt; </font></tt>
<br>
<br><tt><font size=2>That shouldn't be an issue as the PURR is supposed
to be virtualized by PHYP at </font></tt>
<br><tt><font size=2>the virtual processor level.</font></tt>
<br>
<br><tt><font size=2>Luke</font></tt>
--=_alternative 000B3E65832571AE_=--
