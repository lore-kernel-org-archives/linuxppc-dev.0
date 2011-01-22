Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1BE17B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 13:31:57 +1100 (EST)
Received: by iwb12 with SMTP id 12so2529088iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 18:31:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimbZh5KCD2tT3rE5prhOBV9D_-QVdLyu0usmvMw@mail.gmail.com>
References: <AANLkTimbZh5KCD2tT3rE5prhOBV9D_-QVdLyu0usmvMw@mail.gmail.com>
Date: Fri, 21 Jan 2011 20:31:55 -0600
Message-ID: <AANLkTime0kT7rpVKvqZZ1uyib8GqBkgpQ6osDnfCrN0p@mail.gmail.com>
Subject: Re: elf section .text.unlikely
From: kevin diggs <diggskevin38@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For what it is worth, this section contains dump_stack, panic, and printk

Thanks!

kevin

On Fri, Jan 21, 2011 at 7:40 PM, kevin diggs <diggskevin38@gmail.com> wrote:
> Hi,
>
> I am trying to get a PowerMac 8600 to boot past 2.6.28.
>
> I can boot 2.6.28 compiled with either 3.3.3 or 3.4.6. I can't get
> 2.6.28 to boot using 4.3.5. The 4.3.5 vmlinux has a section
> '.text.unlikely' that the 3.4.6 version does not. Anyone know what
> this might be?
>
> kevin
>
