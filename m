Return-Path: <jakemagee@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4BAC0D4B.3030507@fulcrummicro.com>
References: <4BAC0D4B.3030507@fulcrummicro.com>
Date: Wed, 14 Apr 2010 08:55:28 -0500
Message-ID: <t2wa8142e731004140655p230f7094idc29e489ea09e848@mail.gmail.com>
Subject: Re: Resetting PCI-E devices after linux boot
From: Jake Magee <jakemagee@gmail.com>
To: Dan Wilson <dwilson@fulcrummicro.com>
Content-Type: multipart/alternative; boundary=001636c5b99c1213c2048432bbc5
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636c5b99c1213c2048432bbc5
Content-Type: text/plain; charset=ISO-8859-1

Dan,

Were you able to get PCI-E hotplug working?  I could not get this working
myself and assumed that driver support was lacking.  I'm actually using a
PPC405.

Thanks,
Jake


On Thu, Mar 25, 2010 at 8:26 PM, Dan Wilson <dwilson@fulcrummicro.com>wrote:

> We are building a PCI-E device for use in an embedded system with an 85xx
> processor.  One of our customers is adamant that linux PCI-E hot-swap
> support will not allow us to either bring the device up after linux boot
> (i.e., the PCI-E device must be present when linux scans for PCI-E devices
> at startup) or to reset the device once linux is up.  It was our impression
> that the PCI-E hot-swap support should allow for devices to appear after
> linux boot, be properly initialized, and then later be able to shut them
> down and bring them back up again.
>
> Has anyone successfully used the PCI-E hot-swap capabilities in the linux
> kernel in a PPC 85xx environment?  Any known gotchas we need to be aware of?
>
> Thanks in advance for your responses,
>
> Dan.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--001636c5b99c1213c2048432bbc5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dan, <br><br>Were you able to get PCI-E hotplug working?=A0 I could not get=
 this working myself and assumed that driver support was lacking.=A0 I&#39;=
m actually using a PPC405.<br><br>Thanks,<br>Jake<br>
<br><br><div class=3D"gmail_quote">On Thu, Mar 25, 2010 at 8:26 PM, Dan Wil=
son <span dir=3D"ltr">&lt;<a href=3D"mailto:dwilson@fulcrummicro.com">dwils=
on@fulcrummicro.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204=
, 204); padding-left: 1ex;">
We are building a PCI-E device for use in an embedded system with an 85xx p=
rocessor. =A0One of our customers is adamant that linux PCI-E hot-swap supp=
ort will not allow us to either bring the device up after linux boot (i.e.,=
 the PCI-E device must be present when linux scans for PCI-E devices at sta=
rtup) or to reset the device once linux is up. =A0It was our impression tha=
t the PCI-E hot-swap support should allow for devices to appear after linux=
 boot, be properly initialized, and then later be able to shut them down an=
d bring them back up again.<br>

<br>
Has anyone successfully used the PCI-E hot-swap capabilities in the linux k=
ernel in a PPC 85xx environment? =A0Any known gotchas we need to be aware o=
f?<br>
<br>
Thanks in advance for your responses,<br>
<br>
Dan.<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxppc=
-dev@lists.ozlabs.org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

--001636c5b99c1213c2048432bbc5--
