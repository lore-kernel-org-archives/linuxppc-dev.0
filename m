Message-ID: <3C45ABAF.4050507@galileo.co.il>
Date: Wed, 16 Jan 2002 18:34:55 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: PowerPC / other compilers
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

This is not PowerPC Linux issue, but I couldn't find out a better place
to post it :)

I have an application I'v compiled with certain toolchain (for PowerPC
and other targets), and I want to distribute the application in binary
(no loadable modules or dynamic linked libraries, just plain C files
with headers files that gives out certain API).

What I need to know, is how I can make sure that when another person
gets my binaries he can link them with his application and work well ?

The factors that I can identify till now are two -
1.. Distribute the binary in ELF format (are there any compilers that
don't support ELF ? )
2.. Compile the binary that it is EABI compliant (what are the
differences between EABI and ABI ?)

Please add more factors that should be checked, or even suggest another
approach to overcome this problem (other than I get the other person
tool chain and compile the sources with them).

Thanks alot,
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
