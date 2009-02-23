Return-Path: <sumedhtirodkar@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 355BBDDEDF
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 18:55:41 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1761151rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 23:55:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <00F33F10-8CD0-465F-9545-46009AA85E8E@kernel.crashing.org>
References: <d2b9ccd90902120159k4f6024bbl831b43073d4126f3@mail.gmail.com>
	<00F33F10-8CD0-465F-9545-46009AA85E8E@kernel.crashing.org>
Date: Mon, 23 Feb 2009 13:25:40 +0530
Message-ID: <d2b9ccd90902222355i28f4fa3flec281ee789e8fcfc@mail.gmail.com>
Subject: Re: PowerPC 7447A Paging table Search
From: sumedh tirodkar <sumedhtirodkar@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks a lot...Its working now...

Regards,
Sumedh

On Thu, Feb 12, 2009 at 7:28 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Feb 12, 2009, at 3:59 AM, sumedh tirodkar wrote:
>
>> How will i confirm if PowerPC 7447A processor has or does not have a
>> dedicated hardware for page table search algorithm?
>> If it does not have, then which interrupt handler is written for page
>> address translation mechanism?
>
> It has one and linux uses it.
>
> - k
>
