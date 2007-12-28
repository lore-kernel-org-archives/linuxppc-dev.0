Return-Path: <www@tchaikovsky.artsenscene.org>
Received: from tchaikovsky.artsenscene.org (crazy.xmat.net [91.121.11.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BE7ADDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 23:37:08 +1100 (EST)
To: jonsmirl@gmail.com
Subject: Re: [PATCH 0/5] Version 17,  series to add device tree naming to i2c
Message-ID: <uyqq2ui6.1198844066.4263970.khali@gcu-squad.org>
In-Reply-To: <9e4733910712270847j35778e43i66fda3eca9dc125@mail.gmail.com>
From: "Jean Delvare" <khali@linux-fr.org>
Errors-To: "Jean Delvare" <khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: World Wide Web Owner <www@tchaikovsky.artsenscene.org>
Date: Fri, 28 Dec 2007 13:14:28 +0100
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi John,

Le 27/12/2007, Jon Smirl =E9crit:
>On 12/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Another rework of the i2c for powerpc device tree patch. This version impl=
ements standard alias naming only on the powerpc platform and only for the de=
vice tree names. The old naming mechanism of i2c_client.name,driver_name is l=
eft in place and not changed for non-powerpc platforms. This patch is fully c=
apable of dynamically loading the i2c modules. You can modprobe in the i2c-mp=
c driver and the i2c modules described in the device tree will be automatical=
ly loaded. Modules also work if compiled in.
>
>Are there any further objections to this patch? Can it all go in
>through the powerpc trees or do the i2c people want to send it on?

I am on vacation until January 4th. I will review your patchset the week
following my return.

Thanks for your patience,
--
Jean Delvare
