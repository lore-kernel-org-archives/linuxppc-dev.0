In-Reply-To: <3749CC04.146B318D@eos.ncsu.edu>
Date: Tue, 25 May 1999 12:42:15 +0200
To: Scott Sams <sbsams@eos.ncsu.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: AWACS Bug
Message-Id: <19990525124215.002323@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, May 24, 1999, Scott Sams <sbsams@eos.ncsu.edu> wrote:

>Paul Mackerras <paulus@cs.anu.edu.au> wrote:
>
>> What's happening is I think the same as what happens on the iMac: when
>> you run the BootX app to boot linux, and it asks macos to shut down,
>> macos shuts down the awacs, in such a fashion that the only thing that
>> will start it up again is a hard reset. :-( 

I do have a fix for that but this fix is still not tested and not in
BootX. I'll try to find some time to finish sometimes this week. (The fix
is a hack: I patch the MacOS burgundy driver to prevent the shutdown.
Also this works only with versions of the driver that do export their
function names thru the TOC, which may not be the case of future versions).


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
