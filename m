Message-ID: <XFMail.981208113817.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <19981207200522.A4510@tiktok.cygnus.com>
Date: Tue, 08 Dec 1998 11:38:17 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Michael Meissner <meissner@cygnus.com>
Subject: Re: EGCS 1.1.1 FYI
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
        Ralf Weidemann <RalfW@Scalar.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 08-Dec-98 Michael Meissner wrote:
> 
> On Mon, Dec 07, 1998 at 11:22:42PM +0100, Ralf Weidemann wrote:
>> But on the other side I also tried to run the SeaMonkeyBrowser
>> (Mozilla) from recent cvs-sources. Building went fine, but the
>> beast didn't run. I get only a simple "Aborted" message on the
>> console and it seems to crash somewhere in the startup code.
>> So maybe this is somehow related ?
> 
> If SeaMonkeyBrowser calls through a trampoline inside of static constructors,
> then yes, this is a symptom.
> 

I'm sure that the problem is here.  If you've built code with a compiler
that *does not have* the trampoline patch (which is what I think you've
done with Mozilla) then the startup for 'libstdc++' will fail (amoung
others).

I've built a new EGCS-1.1.1 which can be used with existing code until
the new GLIBC-2.1.xx is ready.  You can get this from:
  ftp://ftp.linuxppc.org/pub/gary/redhat/RPMS/ppc
Pick up the 'egcs-1.1-1b*' packages.

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
