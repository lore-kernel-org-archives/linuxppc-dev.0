Message-ID: <3E487057.8000100@elitedvb.net>
Date: Tue, 11 Feb 2003 04:39:03 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: file alignment of elf sections
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,

i'm currently porting u-boot to a ppc405-based board, but i'm failing
miserably at the first step - correct linking.

to make it short (and keep it a bit ontopic, sorry):

how can i tell ld to align the section in the FILE to 2^16 ? i have my
.text-section started at (loading address) 5MB, and like to have it in
the elf-file at 64k.  i saw lds producing exactly this output, but in my
case the .text-section starts immediately after the elf header.  (the
reason is that i have to convert the binary to a special format for the
primary bootloader, and the tool for converting is rather dumb, but i
don't want to invest time into fixing the tool since i didn't wrote it
and nobody else cares about it).

There must be a simple option, but i can't find it :/  (even after
googling around)

I have to admit that i did this before, but i can't remember HOW i did it.

felix


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
