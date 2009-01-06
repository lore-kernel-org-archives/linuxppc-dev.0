Return-Path: <jwboyer@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id B864ADE0F8
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:13:10 +1100 (EST)
Received: by ewy13 with SMTP id 13so9560080ewy.9
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Jan 2009 08:13:08 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 6 Jan 2009 11:12:06 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Copy bootable images in the default install
	script
Message-ID: <20090106161206.GA2325@yoda.jdub.homelinux.org>
References: <20081220005720.23861.18505.stgit@localhost.localdomain>
	<20090105150025.GA26783@zod.rchland.ibm.com>
	<fa686aa40901050728w3bb34bamd66345181fed76d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40901050728w3bb34bamd66345181fed76d6@mail.gmail.com>
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 05, 2009 at 08:28:56AM -0700, Grant Likely wrote:
>On Mon, Jan 5, 2009 at 8:00 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
>>
>> On Fri, Dec 19, 2008 at 05:57:20PM -0700, Grant Likely wrote:
>> >From: Grant Likely <grant.likely@secretlab.ca>
>> >
>> >This patch makes the default install script (arch/powerpc/boot/install.sh)
>> >copy the bootable image files into the install directory.  Before this
>> >patch only the vmlinux image file was copied.
>>
>> What do you do for cases where there isn't a single file?  E.g. a
>> canyonlands board will need both the uImage and caynonlands.dtb files
>> to be "installed".  U-Boot needs to be provided with both of them.
>
>That is exactly what this patch does.  It copies all of the image
>files in $(image-y).

Well, it would if the .dtb files were includes in image-y, but they
aren't.  Anyway, that doesn't seem to be a bug or short-coming of the
patch itself, so this looks good to me.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
