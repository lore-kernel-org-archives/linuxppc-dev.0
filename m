Date: Tue, 11 Jun 2002 11:20:22 +0800
From: "Daniel Lao" <laodx@gzjpg.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Why I can't bind the 1023 port?
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Message-Id: <200206111148421.SM00168@------>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yes, only root can access the ports less than 1024.
Just now I saw that rcp was a SUID routine, so it must be able to bind that port.
Maybe I made some other mistakes.
Thanks for your help.

I am sorry my post is a little off topic :)

>
>Yes, ports < 1024 are reserved ports for "public" applications and only
>the superuser can bind them. To use them, you need to be a superuser. I
>am not familar with rcp (I would use scp even for local transfers) but
>it should be able to run on another port.
>
>Owen
>
>--
>Owen Stampflee - owen@penguinppc.org
>http://penguinppc.org/~owen

---
Daniel Lao
2002-06-11 11:07:13


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
