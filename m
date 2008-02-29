Return-Path: <jwilson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 521C7DDE1A
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 02:35:14 +1100 (EST)
From: Jarod Wilson <jwilson@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] firewire: endianess fix
Date: Fri, 29 Feb 2008 10:34:35 -0500
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<47C79CB1.6050104@redhat.com>
	<18375.60394.166769.540668@cargo.ozlabs.ibm.com>
In-Reply-To: <18375.60394.166769.540668@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802291034.35910.jwilson@redhat.com>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 February 2008 06:26:34 am Paul Mackerras wrote:
> Jarod Wilson writes:
> > Still no luck finding one here. The person I was thinking of has a
> > Lombard, which has no firewire. I did get ahold of a 667MHz Titanium,
> > but its got an Agere FW323. Pretty sure my old man actually has a Pismo,
> > but its about a 3000 mile drive over to my folks house. The search
> > continues... I wonder how many people still actually 1) have a machine
> > with this controller, 2) are running Linux on it and 3) use firewire
> > devices with it. Both of you, please speak up, we're trying to help you!
> > (if only out of morbid curiosity to see this mythical goofy controller).
>
> I have a first-generation titanium powerbook that has this controller
> (assuming we're talking about vendor/device id = 0x106b / 0x18), and
> yes I run Linux (only) on it and use firewire disks. :)

Yup, seems that's the one. Sounds like we had another one hiding in plain site 
in Stefan's hands too, the thing just was meeting criterion #2. ;)


-- 
Jarod Wilson
jwilson@redhat.com
