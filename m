Message-ID: <3F6BCBA6.3000405@kegel.com>
Date: Fri, 19 Sep 2003 20:38:14 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Todd <to_dd@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: exernalizing module functions to user space
References: <20030919192939.31485.qmail@web40412.mail.yahoo.com>
In-Reply-To: <20030919192939.31485.qmail@web40412.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Todd wrote:
> I would like to make certain functions in my driver
> available to user space applications.  At first it
> seemed that EXTERN_SYMBOL was the solution, but this
> appears to externalize the functions only to other
> modules.
> I considered adding specialized entries in the
> file_operations structure...but this does not seem
> appropriate.  Can anyone explain the proper method of
> acheiving this??

Yes.  This is an extremely basic question, you may wish
to grab a book or two on linux kernel programming.
The kernel is in a different address space than user code,
so you can't use direct calls.
Write a syscall, an ioctl, a driver, or create /proc entries.
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
