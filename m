Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 64685DEDAC
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 05:34:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix cpm uart corruption with PREEMPT_RT
Date: Tue, 20 May 2008 14:35:26 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B046E75A5@ismail.innsys.innovsys.com>
In-Reply-To: <20080520193307.GA32130@loki.buserror.net>
References: <20080520192816.7F7E15AF22@innovsys.com>
	<20080520193307.GA32130@loki.buserror.net>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Tue, May 20, 2008 at 02:28:16PM -0500, Rune Torgersen wrote:
>> Fix CPM serial port corruption when running with CONFIG_PREEMPT_RT.
>> Userland usage of console, and kernel printf's were stepping on each
>> others toes.=20
>>=20
>=20
> We should bypass the lock when oops_in_progress is set, something
> like:=20
>=20

Ok, will respin.
