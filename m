Return-Path: <larry.finger@gmail.com>
Received: from mail-yw0-x22e.google.com (mail-yw0-x22e.google.com
 [IPv6:2607:f8b0:4002:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCLX86N1szDvP3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 05:27:36 +1100 (AEDT)
Received: by mail-yw0-x22e.google.com with SMTP id l124so148563366ywb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 10:27:36 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
To: Paul Burton <paul.burton@imgtec.com>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <13471233.iqSeGS5aQ3@np-p-burton>
 <4f990791-ebff-dbe3-b923-3cac5fd6f97d@lwfinger.net>
 <2028257.UuvQgdciME@np-p-burton>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <190a8a8f-228c-6992-393f-70afb3523810@lwfinger.net>
Date: Mon, 7 Nov 2016 12:27:32 -0600
MIME-Version: 1.0
In-Reply-To: <2028257.UuvQgdciME@np-p-burton>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2016 11:21 AM, Paul Burton wrote:
> Hi Larry,
>
> On Monday, 7 November 2016 09:26:37 GMT Larry Finger wrote:
>>> A revert was already submitted by Hans de Goede & is being discussed over
>>> here:
>>>
>>> https://marc.info/?l=linux-kernel&m=147826151427455&w=2
>>
>> I am a little surprised that I was not CCd on that thread.
>
> Hans started that thread without copying you just as you started your thread
> without copying Andreas, who reported issues first.

My searching had failed to find his report.

>> To reiterate, my
>> PowerBook G4 with a PPC32 processor CRASHES on boot. That is a lot more
>> serious than the console output disappearing.
>
> Crashes as in init dies due to lack of a console, right?

It gets a kernel panic because of an attempt to kill process 1 (init). It then 
waits 120 seconds and tries to reboot.

>> As it seems unlikely that this regression will be fixed in the current
>> cycle, I recommend that the reversion of commit 05fd007e4629 until a proper
>> fix is available.
>
> I agree that reverting is probably the best option for now, and have replied
> with that in the other thread too.

Good.

Larry
