From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: Aron.J.Silverton@motorola.com, beena@gdatech.com, dank@kegel.com
Cc: listmember@orkun.us, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Cross-compile package combinations
Date: Tue, 16 Dec 2003 14:07:48 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F44wCQqwJyX2Rc00040a15@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I do have a another question, though.  Let's say that I want to use my own
>kernel instead of having crosstool download it.  What would be the proper
>set of steps to take to specify a local kernel?  My current kernel is
>2.4.20 and I know that the combination of gcc and glibc that I want to use
>with crosstool specifies 2.4.21.  I'll probably work on bumping my kernel
>up.
>
>Aron

The way I did this was to use crosstool to just create the cross-compiler
for me. From there I took it upon myself to install it in the appropriate
directory and then compile the kernel I wanted. That proved to be easy
enough for me.

~Ashwin




>From: Silverton Aron-C1710C <Aron.J.Silverton@motorola.com>
>To: "'Beena'" <beena@gdatech.com>, "'Dan Kegel'" <dank@kegel.com>
>CC: "'Ashwin Bihari'" <raz0redge@hotmail.com>,
>"'listmember@orkun.us'" <listmember@orkun.us>,
>"'linuxppc-embedded@lists.linuxppc.org'"
><linuxppc-embedded@lists.linuxppc.org>
>Subject: RE: Cross-compile package combinations
>Date: Tue, 16 Dec 2003 12:53:40 -0600
>
>
>I also had success using crosstool.  Thanks to all those who gave me tips
>both on the list and via email.
>
>
>Beena <mailto:beena@gdatech.com> wrote:
> > I used crosstool and was able to effortlessly install gcc 3.3.2,
> > glibc 2.3.2 for powerpc. Thanks a lot for your suggestion.
> >
> > -Beena
> >
> > -----Original Message-----
> > From: Dan Kegel [mailto:dank@kegel.com]
> > Sent: Thursday, December 11, 2003 8:26 PM
> > To: Beena
> > Cc: Silverton Aron-C1710C; 'Ashwin Bihari'; listmember@orkun.us;
> > linuxppc-embedded@lists.linuxppc.org Subject: Re: Cross-compile
> > package combinations
> >
> >
> > Beena wrote:
> >> I have observed the same errors when trying to build the
> >> bootstrap gcc
> >> 3.2.3. I understand that this is because gcc 3.2.3 build (in
> >> case of powerpc) looks for some glibc files. So I first built
> >> gcc 2.95.3, then glibc 2.2.1 and then built bootstrap gcc
> >> 3.2.2(you could try with
> >> 3.2.3) and it compiled fine.
> >
> > One of the reasons I did crosstool was to avoid that kind of
> > hackery.  With crosstool, you don't need to build gcc 2.95.3 just
> > to build gcc 3.2.3.  Crosstool does clean builds from pristine,
> > minimally patched source.
> > - Dan
>
>

_________________________________________________________________
Cell phone ‘switch’ rules are taking effect — find out more here.
http://special.msn.com/msnbc/consumeradvocate.armx


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
