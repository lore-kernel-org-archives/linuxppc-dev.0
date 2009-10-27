Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id D6D42B7BC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 07:09:13 +1100 (EST)
Received: by yxe9 with SMTP id 9so98451yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 13:09:11 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200910272054.47398.roman.fietze@telemotive.de>
References: <mailman.1186.1256651657.12812.linuxppc-dev@lists.ozlabs.org>
	<200910271549.n9RFn3ep028623@nti1.com>
	<200910272054.47398.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Oct 2009 14:08:51 -0600
Message-ID: <fa686aa40910271308oa94ad4dkeff41859b6c4725a@mail.gmail.com>
Subject: Re: Micrel PHY KSZ8001 on MPC5200B FEC
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 27, 2009 at 1:54 PM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hello Suvidh,
>
> On Tuesday 27 October 2009 17:47:51 suvidh kankariya wrote:
>
>> A driver for micrel phy exists in /drivers/net/phy/micrel.c. in
>> 2.6.30.
>
> Am I somewhat blind, or do you have access to other 2.6.30's than I
> have?
>
> I searched git.kernel.org, git.denx.de and git.secretlab.ca, but could
> not find that file, neither in the current master, nor in older tags
> somewhat related to "2.6.30", nor in any local clone in any version of
> the 2.6 since "He" created the repos.

No, there is a marvell driver, but not a micrel one.  If the generic
phy driver doesn't work for you, then yes, add a new micrel driver.
To hook it up to the MPC5200 FEC, you just need to have the correct
PHY address in your board's .dts file.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
