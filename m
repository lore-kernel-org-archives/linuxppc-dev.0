Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 83AF3DE08A
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 02:16:27 +1100 (EST)
Date: Fri, 10 Oct 2008 19:16:25 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] i2c: MPC8349E-mITX Power Management and GPIO
	expander driver
Message-ID: <20081010151625.GA7462@oksana.dev.rtsoft.ru>
References: <20080923141300.GB31262@oksana.dev.rtsoft.ru>
	<683C10AE-E5F2-4196-B2C7-1E1CC317EC24@kernel.crashing.org>
	<20081010144545.GA956@oksana.dev.rtsoft.ru>
	<CB31A54E-7518-4E26-8A5C-AC3CBB0F1384@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <CB31A54E-7518-4E26-8A5C-AC3CBB0F1384@kernel.crashing.org>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	Ben Dooks <ben-linux@fluff.org>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 09:58:44AM -0500, Kumar Gala wrote:
[...]
>>> is the plan to connect ppc_md.machine_shutdown() with this?
>>
>> You mean poweroff? It's already connected.
>>
>> +       /* XXX: this is potentially racy, but there is no lock for  
>> ppc_md */
>> +       if (!ppc_md.power_off) {
>> +               glob_mcu = mcu;
>> +               ppc_md.power_off = mcu_power_off;
>> +               dev_info(&client->dev, "will provide power-off  
>> service\n");
>> +       }
>
>
> uuh, yeah.. poweroff :)
>
> and look at that.  Is this in Jean's queue?

Nope. Here's what Jean wrote:

On Wed, Oct 01, 2008 at 01:22:48PM +0200, Jean Delvare wrote:
> I do not have the time to review these patches (and, honestly, have no
> interest in them.) So I will not merge them but I have no objection to
> them being merged by somebody else.

So.. I think it could easily go through the powerpc tree.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
