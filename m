Message-Id: <3.0.3.32.20030109121206.0073f7a8@hollabaugh.com>
Date: Thu, 09 Jan 2003 12:12:06 -0700
To: "Aman" <aman@mistralsoftware.com>,
	"linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: Calling Application
In-Reply-To: <001b01c2b810$7ec76720$370da8c0@aman>
References: <1040427361.1096.27.camel@granite.austin.ibm.com>
 <1042053852.1207.176.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:24 AM 1/10/2003 +0530, Aman wrote:
>
>Hi All
>
>This might be a basic question. I have build the linux kernel for custom
>board which has PPC 440GP as its processor. I have also build my
>application. Now I wanted to call my application after the kernel boots up.
>Can you tell me where I hv to call my application.


look at /etc/inittab, put your application in one of those scripts or call it directly from the within the inittab, much like the gettys.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
