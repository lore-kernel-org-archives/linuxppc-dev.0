To: Jan Damborsky <jan.damborsky@devcom.cz>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: X windows for Linux PPC embedded 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Feb 2003 18:12:42 +0100."
             <3E5A528A.4020805@devcom.cz>
Date: Mon, 24 Feb 2003 22:48:08 +0100
Message-Id: <20030224214813.6D2FAC6E0C@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3E5A528A.4020805@devcom.cz> you wrote:
>
> I would like to ask, if there is some project
> for porting X windows system to Embedded
> PPC Linux. I use board with MPC823E with
> VGA TFT display+touch screen, 32MB RWM,
> 4MB FLASH, Ethernet, serial RS232,....
> I would like to use it as remote graphic terminal
> communicating via Ethernet by means of X protocol.
> Does somebody know how to make it work ?

There is nothing much to "port". Just use a system with  as  much  as
possible RAM, and a local harddisk, so you can enable swap space, and
run the standard "make" procedure on the target (native!).

I once looked into this trying to find out if you could prepare X11R6
for cross compilation, but found it too difficult  /  not  worth  the
effort.  I  ran  a  build  on  a  MPC860P  with 64 MB RAM and a 20 GB
harddisk attached to the PCMCIA slot. It took  _ages_  (>  48  hours,
IIRC)  but  except  for  some  minor issues the build went through. I
think this was in the  age  of  HHL  1.2  JE,  so  any  decent  build
environment should work fine, too.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Hacking's just another word for nothing left to kludge.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
