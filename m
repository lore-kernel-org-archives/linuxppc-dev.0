Return-Path: <LukeBrowning@us.ibm.com>
In-Reply-To: <20060716035353.GA5266@pb15.lixom.net>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
MIME-Version: 1.0
Message-ID: <OFFBAD5953.E17A24C8-ON832571AD.007DA01D-832571AD.007DBBB5@us.ibm.com>
From: Luke Browning <LukeBrowning@us.ibm.com>
Date: Sun, 16 Jul 2006 20:53:21 -0200
Content-Type: multipart/alternative;
	boundary="=_alternative 007DBBB4832571AD_="
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
--=_alternative 007DBBB4832571AD_=
Content-Type: text/plain; charset="US-ASCII"

linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 
07/16/2006 12:53:54 AM:

> On Sat, Jul 15, 2006 at 02:00:02AM +0200, Arnd Bergmann wrote:
> 
> > What happened to the question whether to use PURR values for also 
measuring
> > cycles spent executing the hcall as opposed to cycles that passed 
before
> > the hcall returns. Did that turn out not giving extra information 
after all
> > or was there a different reason to drop that idea?
> 
> Just so people don't forget: this can't be done on all processors. For
> example, PPC970 and POWER4 don't implement the PURR SPR. And it doesn't
> make sense to use H_PURR to get the software emulated ones there. Not
> really an issue on POWER4 since they don't do shared processor LPAR, but
> on JS21 I think they might do?
> 
Isn't there someway to do a platform specific processor overlay, where you 

get PURR if it exists and TB otherwise.

Luke

--=_alternative 007DBBB4832571AD_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><tt><font size=2>linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org
wrote on 07/16/2006 12:53:54 AM:<br>
<br>
&gt; On Sat, Jul 15, 2006 at 02:00:02AM +0200, Arnd Bergmann wrote:<br>
&gt; <br>
&gt; &gt; What happened to the question whether to use PURR values for
also measuring<br>
&gt; &gt; cycles spent executing the hcall as opposed to cycles that passed
before<br>
&gt; &gt; the hcall returns. Did that turn out not giving extra information
after all<br>
&gt; &gt; or was there a different reason to drop that idea?<br>
&gt; <br>
&gt; Just so people don't forget: this can't be done on all processors.
For<br>
&gt; example, PPC970 and POWER4 don't implement the PURR SPR. And it doesn't<br>
&gt; make sense to use H_PURR to get the software emulated ones there.
Not<br>
&gt; really an issue on POWER4 since they don't do shared processor LPAR,
but<br>
&gt; on JS21 I think they might do?<br>
&gt; <br>
Isn't there someway to do a platform specific processor overlay, where
you </font></tt>
<br><tt><font size=2>get PURR if it exists and TB otherwise.</font></tt>
<br>
<br><tt><font size=2>Luke<br>
</font></tt>
--=_alternative 007DBBB4832571AD_=--
