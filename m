Message-Id: <199812091834.LAA12657@mail.fiber.net>
Subject: Re: Installation Problems with PB G3/266
Date: Wed, 9 Dec 98 11:38:45 -0000
From: cehansen <cehansen@fiber.net>
To: "Matthew Fong" <mattfong@ucla.edu>, <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I've been having the same problem for about 2 months now and it's
>becoming really frustrating.Several people have already given me
>suggestions, but none of them seem to work.
>
>Whenever I attempt to install LinuxPPC R4, i keep getting the message:
>
>"install exited abnormally -- received singal 11
> sending termination signals ...done
> sendking kill singals ...done
> unmounting filesystems... /proc
> you may safely reboot you system"
>
>No matter if i use floopy install or bootX (tried all the kernels) this
>still happens. So far, no one has been able to help. I have a PowerBook
>G3/266 with 64 MB of RAM, MacOS 8.5 (used drive setup 1.6.1). Has anyone
>had these problems before?
>
>I copied all the files to an HFS parition to install and tried the
>CD-ROm under bootX. Neither works ...
>
>Any help is appreciated.
>
Matthew,

I think that I can help.  I have a PB G3 292 and I've been using linuxppc 
on it for a couple of months now.  What I found is that I couldn't get 
_either_ the powerbook's internal hard drive _or_ the media bay CD-ROM to 
work.  There is at least one account that I know of where someone did get 
the internal HD to work it's in the Linux section of Ogrady's Power Page:

http://ogrady.com/articles/linux.stm

(you'll have to scroll down a bit since all of the information compiled 
is on the same html page--regardless of the type of powerbook)  Also, 
this page is pre-BootX so some of the material is dated.  For the record, 
I use BootX on my PB and _love_ it (hey, I can boot off the internal HD 
now =)  But in spite of this, whether you install off the internal HD or 
not, this information is _very_ helpful.  However, there are at least 
three other ways to install Linux on a PB G3 that will work:

1)  Use an external CD-ROM drive.  This is what I did.  I have an old 
apple 4x CD-ROM that I plugged in and that worked great the first time!  
(I'd been having the same problems that you're having.)

2)  Use an external hard drive.  It seems that some of the early 
literature that I read suggested this.  And like I said, I never could 
get the installer to recognize my internal HD correctly.

3)  If you have another Mac with an ethernet card, use a crossover cable 
(I think that's what they're called) and connect your computers via 
ethernet (the installer will recognize the internal ethernet on the PB 
G3).  Then, install something like NetPresenz(sp?) on the other Mac (if 
you have a better FTP package, so much the better, but NetPresenz works 
fine), set up the relevant permissions for where ever you've got the red 
hat directory (if necessary), and install via FTP.  Of course, if you 
have a fast connection to the net, you can by-pass the second Mac and 
install directly from one of the linuxppc mirrors out on the net, but I 
didn't have that luxury <sigh>.

Anyway, that should give you a number of options that will work.  Let me 
know if you need any more info and I'll help where I can (my linux 
experience amounts to the couple of months that I've had it installed on 
my PB.)  There are still some things that I'm working on (like getting 
the internal modem to use my internal speakers) but that's another 
e-mail.  HTH.  Regards,

--Chris Hansen

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
