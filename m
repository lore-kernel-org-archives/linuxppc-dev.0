Message-Id: <200201021918.OAA13583@missioncriticallinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to gt64260 interrupt support code
Date: Wed, 02 Jan 2002 14:18:54 -0500
From: "Michael O'Donnell" <mod@MissionCriticalLinux.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> The current gt64260 interrupt support code forces
>> use of particular Linux irqs (starting from 0) for
>> particular GT64260 interrupt sources.  These changes
>> allow use of that support code in other platforms and
>> (of particular interest in my situation) in combination
>> with other interrupt controllers (like the elegant
>> and flexible 8259) that also want to map *their*
>> interrupt sources to the Linux irqs starting at 0...
>
>
>Ugh. Did I mention I hate 8259's?
>
>We **REALLY** need a better way to deal with cascaded
>8259's than adding an offset..  I think Dan Malek
>had some good ideas on what to do about this, but I
>don't know that anyone has got any currently running
>code that solves this problem nicely.


We're all agreed: the current interrupt subsystem is
too brittle and needs to be reworked.  Meanwhile, can we
get that patch applied?  I'm in the process of porting
to a new platform and I'm trying to be a good boy and
feed y'all my platform-independent stuff in bite-sized
pieces prior to the larger platform-specific bolus...

Regards,
          Michael O'Donnell
        Mission Critical Linux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
