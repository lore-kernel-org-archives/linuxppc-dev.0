Date: Mon, 13 Mar 2000 14:56:34 -0500
Subject: Re: Xfree86 4.0
From: "James B. Parker" <pajama1@mindspring.com>
To: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B4F2B222.152C%pajama1@mindspring.com>
In-Reply-To: <38CD39B5.A91B1B92@erols.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


<snip> from pogtal@erols.com on 3/13/00 1:55 PM

> "James B. Parker" wrote:
>
>> _first_
>> It asks for a file call libqt.0.2 or something like that (I know the libqt
>> part is correct).  Although this problem may have cleared up after I built
>> it a second time, I tried to reinstall KDE from a rpm (thinking this may
>> solve the second issue) and a message was displayed requesting the above
>> mentioned file.
>
> I would assume that libqt (probably libqt.so.2 or something like that) is part
> of the qt developement package..
>
> According to rpmfind.net, libqt.so.2 is provided by the qt package, you
> probably also want the qt-devel package.

I was a little incorrect.  It is looking for liqt.so.1 and I have libqt.so.2
in my libs folder.  But I will install the qt dev package and see what
happens.

>
>> _second_
>> When I try to start the server (xinit, startx, X) there is a fatal error:
>> no screens
>
> What is the fatal error?  I don't think this would be related to the libqt, as
> qt is a kde package for graphics, and shouldn't be related to the X server
> working/not working (AFAIK).
>
> What is the fatal error?

>> no screens
no screens

James


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
