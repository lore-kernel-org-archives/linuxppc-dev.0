Mime-Version: 1.0
Message-Id: <v04220802b622ea31cf0b@[10.0.0.42]>
In-Reply-To: <200010281936.MAA18635@cisco.com>
References: <200010281936.MAA18635@cisco.com>
Date: Mon, 30 Oct 2000 01:08:29 -0800
To: Michael Norton <mnorton@cisco.com>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: kernel source rpm
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:36 PM -0700 10/28/00, Michael Norton wrote:
>hi,
>
>I am working on an application which requires the header file
><linux/limits.h>.
>Which file do I need to rpm from the LinuxPPC 2000 CD-Rom to install kernel
>source?

Don't do that.  Kernel header files are not intended to be directly
#include'd into user applications.  Use the the GNU C and/or C++
libraries and headers like you're supposed to, and you will not
depend on kernel files at all.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
