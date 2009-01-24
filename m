Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C122D474C2
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 12:47:05 +1100 (EST)
To: Rob Gubler <rgubler@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Ebony DTS compile error
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <e4ef24880901231707y7baad5f6kc1f6bde2c30bf29f@mail.gmail.com>
References: <e4ef24880901231707y7baad5f6kc1f6bde2c30bf29f@mail.gmail.com>
Date: Sat, 24 Jan 2009 02:47:01 +0100
Message-Id: <20090124014701.71561832E425@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Rob Gubler,

in message <e4ef24880901231707y7baad5f6kc1f6bde2c30bf29f@mail.gmail.com> you wrote:
>
> I'm an ELDK 4.2 user.  I'm trying to compile the ebony.dts file included in
> the 2.6.24 kernel but the Device Tree Compiler, dtc, complains of a syntax
> error.

Yes, there is a version conflict. The 2.6.24 kernel still uses an old
dts format, which is incompatible with recent dtc versiosn.

> Is anyone aware of a version of DTC that will compile the ebony.dts file
> included with the 2.6.24 kernel?  Or, an updated ebony.dts file that works
> with DTC 1.2.0-gb2b4990b.  Any other suggestions would be great.  Thanks!

Is there any specific reson for you to use the old 2.6.24 kernel?

If not, I'd recommend that you clone the git repository and use recent
code - this will build fine with current versions of the dtc.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What is tolerance? -- it is the consequence of humanity. We  are  all
formed  of frailty and error; let us pardon reciprocally each other's
folly -- that is the first law of nature.                  - Voltaire
