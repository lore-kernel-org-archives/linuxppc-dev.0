Date: Mon, 7 Dec 1998 13:15:38 GMT
From: costabel@lie.univ-rennes1.fr (Martin Costabel)
Message-Id: <199812071315.NAA07323@lie.univ-rennes1.fr.maths>
To: geert@geert.cs.kuleuven.ac.be
Subject: Re: XF68_FBDev under MkLinux?
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Dec 1998, Geert Uytterhoeven wrote:
>On Sun, 6 Dec 1998, Martin Costabel wrote:
>> Geert Uytterhoeven wrote:
>> > Another thing is keyboard and mouse (ADB) handling. Xpmac uses the plain
>> > /dev/adb device, while XF68_FBDev takes the standard Linux keyboard input and
>> > uses the adbmouse driver. I assume keyboard won't be a problem. But the mouse
>> > requires the adbmouse driver.
>> 
>> Did you fix the problem with the non-working option (alt) keys?
>> In the XF68_FBDev of the new R5beta linuxppc, it is still there.
>> For me (PM6400, standard Apple keyboard and 1-button mouse), XF68_FBDev
>> is pretty much useless. 
>
>What about the XF68_FBDev from XFree86 3.3.3?

I must confess that I am a bit lost among the many different versions of 
XF68_FBDev. For the one from XFree86 3.3.3, do I have to install all of 
XFree86 3.3.3, or does it work with XFree86 3.3.2 which is in linuxppc-pre-R5?
I tried several versions, and both on R4 and on pre-R5, the result was the same.
Except that some versions did not want to run on pre-R5.

I would be the first to assume that this is a problem with my configuration,
except that there were some reports by others who had the same problems,
and I am pretty sure that there is a large silent majority of linuxppc users on power Macs who never tried XF68_FBDev so far.
>
>> If you need more information to get to the bottom of this problem, just
>> say what kind of tests to perform.
>
>Problem is that I don't know anything about ADB, nor have ADB devices :-(

If XF68_FBDev is going to be the standard for everybody, one should make sure
that it works on PowerMacs, too.

--
Martin



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
