Return-Path: <runaway@candw.ms>
Received: from smtp475.redcondor.net (smtp475.redcondor.net [208.80.204.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2YjG1s7LzDt3F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 22:20:00 +1100 (AEDT)
Subject: Re: Canyonlands oops at Shutdown
To: Michael Ellerman <mpe@ellerman.id.au>
References: <572C9109.80804@candw.ms>
 <dabf6045-7fc5-b28e-6dd0-b8fa9ddf04b3@candw.ms>
 <311dd8b5-122d-ae3b-fd5a-dee8377ac431@candw.ms>
Cc: linuxppc-dev@lists.ozlabs.org
From: Julian Margetson <runaway@candw.ms>
Message-ID: <167c4980-fd06-07f4-ab87-f3b10d6343ce@candw.ms>
Date: Mon, 24 Oct 2016 07:19:52 -0400
MIME-Version: 1.0
In-Reply-To: <311dd8b5-122d-ae3b-fd5a-dee8377ac431@candw.ms>
Content-Type: multipart/alternative;
 boundary="------------CB92C2557C218AB41C09A6B5"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------CB92C2557C218AB41C09A6B5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21-Oct-16 6:53 AM, Julian Margetson wrote:
> On 08-May-16 10:12 AM, Julian Margetson wrote:
>> CONFIG_PPC44x_SIMPLE=y
>>
>> CONFIG_POWER_RESET=y
>> CONFIG_POWER_RESET_GPIO is not set
>> # CONFIG_POWER_RESET_GPIO_RESTART is not set
>> # CONFIG_POWER_RESET_LTC2952 is not set
>> # CONFIG_POWER_RESET_RESTART is not set
>> # CONFIG_POWER_RESET_SYSCON is not set
>> # CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
>>
>> CONFIG_WATCHDOG=y
>> CONFIG_WATCHDOG_CORE=y
>> # CONFIG_WATCHDOG_NOWAYOUT is not set
>> # CONFIG_WATCHDOG_SYSFS is not set
>> #
>> # Watchdog Device Drivers
>> #
>> # CONFIG_SOFT_WATCHDOG is not set
>> # CONFIG_GPIO_WATCHDOG is not set
>> # CONFIG_XILINX_WATCHDOG is not set
>> # CONFIG_ZIIRAVE_WATCHDOG is not set
>> # CONFIG_CADENCE_WATCHDOG is not set
>> CONFIG_DW_WATCHDOG=y
>> # CONFIG_MAX63XX_WATCHDOG is not set
>> # CONFIG_ALIM7101_WDT is not set
>> # CONFIG_I6300ESB_WDT is not set
>> # CONFIG_BOOKE_WDT is not set
>> # CONFIG_MEN_A21_WDT is not set
>
> Issue appears again with kernel 4.9-rc1
>
>
>
Working again with 4.9-rc2


--------------CB92C2557C218AB41C09A6B5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 21-Oct-16 6:53 AM, Julian Margetson
      wrote:<br>
    </div>
    <blockquote cite="mid:311dd8b5-122d-ae3b-fd5a-dee8377ac431@candw.ms"
      type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <div class="moz-cite-prefix">On 08-May-16 10:12 AM, Julian
        Margetson wrote:<br>
      </div>
      <blockquote
        cite="mid:dabf6045-7fc5-b28e-6dd0-b8fa9ddf04b3@candw.ms"
        type="cite">
        <pre class="western">CONFIG_PPC44x_SIMPLE=y

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_SYSFS is not set
#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_BOOKE_WDT is not set
# CONFIG_MEN_A21_WDT is not set</pre>
      </blockquote>
      <p>Issue appears again with kernel 4.9-rc1 <br>
      </p>
      <p><br>
      </p>
      <p><br>
      </p>
    </blockquote>
    <p>Working again with 4.9-rc2<br>
    </p>
  </body>
</html>

--------------CB92C2557C218AB41C09A6B5--
