Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <3.0.3.32.20020412141129.0070c384@spudcentral.com>
Date: Fri, 12 Apr 2002 14:11:29 -0600
To: linuxppc-embedded@lists.linuxppc.org
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: MPC8xx fpu support and compiling glib. 
In-Reply-To: <20020412194723.7EACA11258@denx.denx.de>
References: <Your message of "Fri, 12 Apr 2002 10:11:00 PDT."             <3CB71524.46DC9F87@esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:47 PM 4/12/2002 +0200, Wolfgang Denk wrote:
>Also be awre the the  emulation  code  in  the  kernel  is  far  from
>complete or perfect.

Does this mean you recommend no emulation code in the kernel and ALL libraries and ALL applications be compiled with -msoft-float?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
