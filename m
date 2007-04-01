Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc2-s16.bay0.hotmail.com (bay0-omc2-s16.bay0.hotmail.com
	[65.54.246.152]) by ozlabs.org (Postfix) with ESMTP id 78764DDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Apr 2007 08:43:14 +1000 (EST)
Message-ID: <BAY117-F2252F472406315E661E1C2C8610@phx.gbl>
In-Reply-To: <b4b98b690704011100j146fae9ap289b210caa6940f3@mail.gmail.com>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC login puzzle
Date: Sun, 01 Apr 2007 18:31:09 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>
>Are you using anything like busybox?  Which telnet are you using.  It's
>killing me because I know I have run into this same problem.  But I am old
>and I forgot what I did.  I had this problem about 3 years ago.. ugh.
>
>To me it was something with securetty or the like.  There is a config file
>that allows telnet or not.  Another thing to try is to load telnetd with
>more options.  I think there is "-a debug" you can turn on and that will
>turn on the authentication debugging... "-D report" should also help you
>out.


I had a problem like this with telnet on an older linux with busybox and 
tiny login...

my problem had to do with making sure I had /dev/ptyX created...

so I just did:

cd /dev
MAKEDEV pty

not sure if that's your problem, but it's just something else to look into..

-Eric

_________________________________________________________________
Live Search Maps – find all the local information you need, right when you 
need it. http://maps.live.com/?icid=hmtag2&FORM=MGAC01
