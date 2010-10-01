Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id BC3C9B70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 21:30:56 +1000 (EST)
Received: by wyb42 with SMTP id 42so2863243wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Oct 2010 04:30:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
Date: Fri, 1 Oct 2010 07:30:54 -0400
Message-ID: <AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
Subject: Re: Introduce support for little endian PowerPC
From: Josh Boyer <jwboyer@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 5:02 AM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:
>
> On Oct 1, 2010, at 2:05 AM, Ian Munsie wrote:
>
>> Some PowerPC processors can be run in either big or little endian modes,=
 some
>> others can map selected pages of memory as little endian, which allows t=
he same
>> thing. Until now we have only supported the default big endian mode in L=
inux.
>> This patch set introduces little endian support for the 44x family of Po=
werPC
>> processors.
>
> From a community aspect is anyone actually going to use this? =A0Is this =
going to be the equivalent of voyager on x86? =A0I've got nothing against s=
ome of the endian clean ups this introduces. =A0However the changes to misc=
_32.S are a bit ugly from a readability point of view. =A0Just seems like t=
his is likely to bit-rot pretty quickly.

I'm with Kumar on this one.  Why would we want to support this?  I
can't say I would be very willing to help anyone run in LE mode, let
alone have it randomly selectable.

josh
