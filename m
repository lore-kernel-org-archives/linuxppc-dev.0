Return-Path: <dceravigupta@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 7BA35B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 22:37:24 +1000 (EST)
Received: by pwi4 with SMTP id 4so82338pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Sep 2010 05:37:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C88AF1E.8010608@windriver.com>
References: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>
	<4C85CCD6.3020504@windriver.com>
	<AANLkTi=bDOtCxW9VuXrSyAiCLoFCvWoskORpc_1ebDe7@mail.gmail.com>
	<4C8604E1.4080908@windriver.com>
	<AANLkTimLO+xf2Z1zoQfZ8bfB-b--Uu701afr7zg+1r6k@mail.gmail.com>
	<4C88AF1E.8010608@windriver.com>
Date: Thu, 9 Sep 2010 18:07:22 +0530
Message-ID: <AANLkTik1gWKO6vif+HgtM-j_5EUMJGwKRf+saRgK4TZg@mail.gmail.com>
Subject: Re: pci_request_regions() failure
From: Ravi Gupta <dceravigupta@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: multipart/alternative; boundary=000e0cd21480473ac1048fd2e44e
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd21480473ac1048fd2e44e
Content-Type: text/plain; charset=ISO-8859-1

Hi Tiejun,

Thanks for the reply.

Omm.
>
> Often we always disable this pref windows so please disable this window.
> Try use
> the following ways to clear PCI_PREF_MEMORY_BASE and PCI_PREF_MEMORY_LIMIT.
> ------
>        pci_write_config_word(dev, PCI_PREF_MEMORY_BASE, 0);
>        pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, 0);
>
>
I have a little confusion about what you said. You said I should disable
prefetched window corresponds to PCI Bridge to [bus 02-ff], the dmesgs shows
that it is already disabled.

pci 0001:01:00.0: PCI bridge to [bus 02-ff]
pci 0001:01:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
*pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
(disabled)*

Is it something that I am not getting right or you have miss read something?
If it is problem with me, then what should be the O/P in case when I disable
the prefetch window (by issuing pci_write_config_word(dev,
PCI_PREF_MEMORY_BASE, 0); and pci_write_config_word(dev,
PCI_PREF_MEMORY_LIMIT, 0); function calls)? And also, I will be really
thankful to you if you also tell me the function in which I should place
there function calls as I am new to linux device driver programming.

Regards,
Ravi

--000e0cd21480473ac1048fd2e44e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tiejun,<br><br>Thanks for the reply.<br><br><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border=
-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im">
</div>Omm.<br>
<br>
Often we always disable this pref windows so please disable this window. Tr=
y use<br>
the following ways to clear PCI_PREF_MEMORY_BASE and PCI_PREF_MEMORY_LIMIT.=
<br>
------<br>
 =A0 =A0 =A0 =A0pci_write_config_word(dev, PCI_PREF_MEMORY_BASE, 0);<br>
 =A0 =A0 =A0 =A0pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, 0);<br>
<div><div class=3D"h5"><br></div></div></blockquote><div><br>I have a littl=
e confusion about what you said. You said I should=20
disable prefetched window corresponds to PCI Bridge to [bus 02-ff], the=20
dmesgs shows that it is already disabled. <br>
<br>
pci 0001:01:00.0: PCI bridge to [bus 02-ff]<br>

pci 0001:01:00.0:=A0=A0 bridge window [io=A0 0x0000-0x0000] (disabled)<br>

pci 0001:01:00.0:=A0=A0 bridge window [mem 0x00000000-0x000fffff] (disabled=
)<br>

<b>pci 0001:01:00.0:=A0=A0 bridge window [mem 0x00000000-0x000fffff pref] (=
disabled)</b><br>
<br>
Is it something that I am not getting right or you have miss read=20
something? If it is problem with me, then what should be the O/P in case
 when I disable the prefetch window (by issuing=20
pci_write_config_word(dev, PCI_PREF_MEMORY_BASE, 0); and=20
pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, 0); function calls)?=20
And also, I will be really thankful to you if you also tell me the=20
function in which I should place there function calls as I am new to linux =
device driver programming.<br><br>Regards,<br>Ravi</div></div>

--000e0cd21480473ac1048fd2e44e--
