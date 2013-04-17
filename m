Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
 by ozlabs.org (Postfix) with ESMTP id 102082C013C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 22:27:56 +1000 (EST)
Message-ID: <516E9549.2090806@mlbassoc.com>
Date: Wed, 17 Apr 2013 06:27:53 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Enable CONFIG_DEVTMPFS_MOUNT to ensure /dev can be mounted
 correctly
References: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
 <20130415050129.GB21147@concordia>
 <CA452391058F6D4E9715FB2C29D9312A014D3107@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <CA452391058F6D4E9715FB2C29D9312A014D3107@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013-04-17 05:46, Luo Zhenhua-B19537 wrote:
>> -----Original Message-----
>> From: Michael Ellerman [mailto:michael@ellerman.id.au]
>> Sent: Monday, April 15, 2013 1:02 PM
>>
>> On Thu, Apr 11, 2013 at 09:56:30PM +0800, Zhenhua Luo wrote:
>>> When using recent udev, the /dev node mount requires
>>> CONFIG_DEVTMPFS_MOUNT is enabled in Kernel.
>>
>> Really?
>>
>> I know it makes life easier when you don't have an initramfs, but is it
>> actually required now?
> [Luo Zhenhua-B19537] I didn't use initramfs when the issue is found, I think the option is required to be enabled.
>

Yes, it is required to get udev to work properly (versions of udev
newer than ~173)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
