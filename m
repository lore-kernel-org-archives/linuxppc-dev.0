Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id A31AFDDEC4
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 13:37:02 +1000 (EST)
Date: 12 May 2007 20:36:59 -0700
Message-ID: <20070513033659.25632.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: tnt@246tNt.com
Subject: Re: [PATCH 4/9] powerpc: BestComm core support for Freescale MPC5200
In-Reply-To: <46465295.90309@246tNt.com>
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<11790019223925-git-send-email-tnt@246tNt.com>
	<11790019234031-git-send-email-tnt@246tNt.com>
	<200705130127.08761.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:
> Arnd Bergmann wrote:
> > Why don't you use EXPORT_SYMBOL_GPL?
> Why would I ? Is it mandatory now ?
> I don't really have an objection to non-gpl modules to use the exported
> functions ...
> If Dale or Andrey have, they're free to post a patch to change to _GPL.

Hi Sylvain,

The general recommendation is to use EXPORT_SYMBOL_GPL unless there
is some overriding reason not to.  I agree with that recommendation.
That's my preference for this code, but I'll defer to you Sylvain.

BTW, it's great to see this code being submitted.

-Dale Farnsworth
