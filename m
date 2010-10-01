Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id EBB46B70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 22:05:26 +1000 (EST)
Message-ID: <4CA5CC3C.6020006@mlbassoc.com>
Date: Fri, 01 Oct 2010 05:55:40 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Introduce support for little endian PowerPC
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
	<AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
In-Reply-To: <AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/2010 05:30 AM, Josh Boyer wrote:
> On Fri, Oct 1, 2010 at 5:02 AM, Kumar Gala<galak@kernel.crashing.org>  wrote:
>>
>> On Oct 1, 2010, at 2:05 AM, Ian Munsie wrote:
>>
>>> Some PowerPC processors can be run in either big or little endian modes, some
>>> others can map selected pages of memory as little endian, which allows the same
>>> thing. Until now we have only supported the default big endian mode in Linux.
>>> This patch set introduces little endian support for the 44x family of PowerPC
>>> processors.
>>
>>  From a community aspect is anyone actually going to use this?  Is this going to be the equivalent of voyager on x86?  I've got nothing against some of the endian clean ups this introduces.  However the changes to misc_32.S are a bit ugly from a readability point of view.  Just seems like this is likely to bit-rot pretty quickly.
>
> I'm with Kumar on this one.  Why would we want to support this?  I
> can't say I would be very willing to help anyone run in LE mode, let
> alone have it randomly selectable.

Indeed, I thought we had killed that Windows-NT dog ~15 years ago :-)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
