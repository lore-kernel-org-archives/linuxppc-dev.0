Message-ID: <3BE78CB0.54E8C9F8@wanadoo.fr>
Date: Tue, 06 Nov 2001 01:37:08 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: hemphill@drea.dnd.ca
Cc: yellowdog-general@lists.yellowdoglinux.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Ti Powerbooks and YDL 2.1 - Problems
References: <3BE74DCD.3070407@drea.dnd.ca>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gavin Hemphill wrote:
>
> Well I've just spent an interesting two days documenting a problem with
> the Ti Powerbooks and the 2.4 series kernels.  I have access to two
> 500Mhz Ti's with the Matshita DVD-ROM SR-8187 drives.  When I tried to
> follow Dan Burcaw's experimental instructions on doing a yup update of
> YDL2.0 to 2.1 I ran into the problem that a mount of any CD returned the
> error message "wrong media type" (I hadn't used the CD at all since
> moving to the 2.4 series kernels).

Did you try to mount it via the loop device:

 mount -o loop -t hfs /dev/cdrom /mnt/wherever

If this works, then you hit a kernel bug that was discussed 2 weeks ago
on linuxppc-dev
(thread "hfs cdrom broken in 2.4.13-pre" in
http://lists.linuxppc.org/linuxppc-dev/200110/threads5.html). It seems
to have been introduced around 2.4.10 and IIRC the result of the
discussion was that nobody was going to fix it.

Just a guess, could be something else entirely, of course.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
