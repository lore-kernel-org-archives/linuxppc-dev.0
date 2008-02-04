Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9725DDE37
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 05:09:29 +1100 (EST)
Message-ID: <47A7540E.2010400@freescale.com>
Date: Mon, 04 Feb 2008 12:06:06 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Doug Maxey <dwm@enoyolf.org>
Subject: Re: [PATCH 4/5] ehea: fix phyp checkpatch complaints
References: <1201832451-23634-1-git-send-email-dwm@austin.ibm.com>
	<1201832451-23634-5-git-send-email-dwm@austin.ibm.com>
	<20080201192344.GA4541@loki.buserror.net>
	<19294.1201927197@bebe.enoyolf.org>
In-Reply-To: <19294.1201927197@bebe.enoyolf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@garzik.org>,
	Linux PowerPC List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Doug Maxey wrote:
> On Fri, 01 Feb 2008 13:23:45 CST, Scott Wood wrote:
>> On Thu, Jan 31, 2008 at 08:20:50PM -0600, Doug Maxey wrote:
>>>  /* input param R5 */
>>> -#define H_ALL_RES_QP_EQPO         EHEA_BMASK_IBM(9, 11)
> ...
>>> +#define H_ALL_RES_QP_EQPO	  EHEA_BMASK_IBM(9, 11)
> ...
>> This was better the way it was (before, it was readable at any tab setting);
>> checkpatch is overeager to complain on tab/space issues (it's a bit hard to
>> distinguish indentation from alignment with a regex).
> 
> In emacs, with no special offsets, the lines appear to still line up.

Are you using a tab size other than 8?

> What did happen was spaces were turned to tabs where applicable.

I disagree about the applicability. :-)

> What editor shows a bad alignment?

Any editor that has been configured to a non-default tab size.

-Scott
