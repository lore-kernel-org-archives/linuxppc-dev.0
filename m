To: Ashish R Dhawane <ashish@cdotb.ernet.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot Problem (MPC8260) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Apr 2004 16:37:00 +0500."
             <Pine.OSF.4.21.0404211715180.5736-100000@ws9.cdotb.ernet.in>
Date: Fri, 23 Apr 2004 14:07:48 +0200
Message-Id: <20040423120753.C2E0DC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.OSF.4.21.0404211715180.5736-100000@ws9.cdotb.ernet.in> you wrote:
>
> I am newbie to the Linux Porting. I am having a mpc8260 board(custom
> made). I am trying to configure the cogent mpc8260 board. For a testing

If you have custom hardware, you cannot use the configuration for the
Cogent board. Each board needs special adaptions and configuration.

> purpose, I am running U-Boot in the SDRAM area, but not from the

Why do you do this? If you have read the U-Boot mailing list archives
(You DID read he archives before posting, didn't you???)  you  should
have  learned  that  this  is  not  as  trivial  as it may seem. It's
defintely not an option if you don't know EXACTLY what you are doing.

> flash. I am getting the following error messages. Any help will
> appreciated.
...
> FLASH: *** failed ***
> ### ERROR ### Please RESET the board ###

Well, you ran into an error, obviously because the  flash  memory  on
your  hardware  is  different  from  the  configuration on the Cogent
board.


And bythe way: please post such questions to the U-Boot-users mailing
list instead; they are off topic here.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Don't tell me how hard you work.  Tell me how much you get done.
- James J. Ling

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
