Message-ID: <3EA55C1F.604@mvista.com>
Date: Tue, 22 Apr 2003 10:13:35 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux Login Fails
References: <008801c30875$1f7960b0$370da8c0@aman>
In-Reply-To: <008801c30875$1f7960b0$370da8c0@aman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Aman wrote:
> Hi All
>
> I am using IBM PPC 440 processor. I am downloading a linux image with
> ramdisk. After the linux image comes up , I get login prompt like this
> <none> login:
> If I try to login with root, it waits for some time and again display the
> same
> <none> login:
> Am I missisng some files in the ramdisk.

Sounds like you are missing /sbin/login.  (or it's possible pam or something
else depending on your software..  if you have syslogd running, check your
logs.. it usually becomes pretty obvious.)

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
