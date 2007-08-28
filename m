Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 31464DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 23:50:57 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2264839wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 06:50:56 -0700 (PDT)
Message-ID: <fa686aa40708280650t41046711g4161cc0c5be05d16@mail.gmail.com>
Date: Tue, 28 Aug 2007 07:50:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <Pine.LNX.4.44.0708281531060.3856-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708280602vc00920do459a087c25b830e1@mail.gmail.com>
	<Pine.LNX.4.44.0708281531060.3856-100000@slslc02.psi.ch>
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/28/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> Hi Grant,
>
>         Thanks for your answer.
> I have found in the System.map :
> c020f0c4 b __log_buf
>
> Is the address c020f0c4 relative to the .data segment?

0xc0000000 are virtual kernel addresses; not physical addresses.  If
the MMU is still on, then you need to use the virtual address to
examine memory.  If the MMU is off (such as after reloading u-boot),
then you need to change 0xCxxxxxxx to 0x0xxxxxxxx.

> I understand that when the system hangs I should type in the XMD window
> stop.
>
> Is there anyway to examine the memory from the XMD window? or should I
> reload the u-boot and examine the memory from u-boot?

I don't know; I've never used XMD.  Read the XMD documentation.  You
can do it from u-boot too.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
