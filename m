Message-ID: <3E911523.5050607@mvista.com>
Date: Mon, 07 Apr 2003 01:05:23 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Erik Christiansen <erik@dd.nec.com.au>
Cc: Darin.Johnson@nokia.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc vs. newlib
References: <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com> <3E8E31AD.3050302@mvista.com> <20030407014717.GA742@dd.nec.com.au>
In-Reply-To: <20030407014717.GA742@dd.nec.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Erik Christiansen wrote:
> On Fri, Apr 04, 2003 at 07:30:21PM -0600, Mark Hatle wrote:
>
>>I strongly recommend you stay away from newlib.
>
>
> Mark,
>
>    Is it something related to linux that has given you a bad experience
>    with newlib? (There is no related information in your post, so I'm
>    curious.)
>

In my experience, the only thing newlib is useful for is bootstrapping a system.
  If you have a working system with newlib, more power to you.  I have never had
any success or desire to get that to work.  For a small system libc, uclibc
looks promising.  For a more traditional linux system, glibc is truely the only
way to do it.  (With special tools you can dramatically reduce the size of
glibc, but not as far as most people would like.)

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
