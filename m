Message-ID: <3E552E60.8040701@stinkfoot.org>
Date: Thu, 20 Feb 2003 14:37:04 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM
References: <20030220173252.43c77198.damm@opensource.se>
In-Reply-To: <20030220173252.43c77198.damm@opensource.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I had lots of issues with CONFIG_HIMEM+CONFIG_SMP with a dual G4-533
with 1.5G of RAM, until I started using 2.4.20-ben(x).

Ethan


Magnus Damm wrote:

>Hi,
>
>I recently bought more memory to my G4 Cube.
>The gentoo kernel ppc-sources-2.4.20-r2 gives
>me various oopses when I enable CONFIG_HIGHMEM.
>
>What kernel tree should I try? linuxppc_2_4?
>
>What do people run on their stable machines
>with more than 768Mbyte memory?
>
>thanks.
>
>/ magnus
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
