Date: Thu, 06 Apr 2000 14:23:38 +0100
Subject: Re: Setting up yaboot
From: Mark Steer <mark@insanely-great.co.uk>
To: Olaf Hering <olh@suse.de>, Ethan Benson <erbenson@alaska.net>
CC: Tim Wojtulewicz <Tim.Wojtulewicz@nau.edu>,
        <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5124E69.C45%mark@insanely-great.co.uk>
In-Reply-To: <20000406133706.D10753@suse.de>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on 6/4/2000 12:37 pm, Olaf Hering at olh@suse.de wrote:

>
> On Wed, Apr 05, Ethan Benson wrote:
>
>> On Wed, Apr 05, 2000 at 01:34:42AM -0700, Tim Wojtulewicz wrote:
>>>
>>> If I boot into OF, then type 'boot' at the prompt, I get the
>>> following error message:
>>>
>>> boot load-size=196 adler32=2e0879a0
>>>
>>> DEFAULT CATCH, code=70 at %SRR0: ff80b320  %SRR1:0000b030
>>
>> ain't OF great ;-)
>>
>>> Here's what I have for a os-chooser script:
>>
>> this probably isn't it given the above gibberish, but try adding
>> PowerBook3,1 to the <COMPATIBLE> line below.
>
> This is exactly the question I had now, so it seems we all have to
> update the os-chooser script and add PowerBook3,1 to it.
>
> I will update the suseboot.hqx today, it includes more funny AppleScript
> files for automate the setup process. SCSI Booting is still an issue,
> the only way is to boot directly into yaboot. It works here on many
> differnt machines.
> Why should ELF loading not work?
>
> boot hd:9,\\yaboot in the os-chooser script should be the same like
> hd:9,\\yaboot in boot-device for the OF.
>
> Yes, there is macboot on newer machine, I had no problems so far.
>
> Gruss Olaf
I've recently setup my new Pismo/400 with Linux and, as of this morning,
Darwin 1.0 and I think I'm going to require a hard drive upgrade about 6
months sooner than I'd planned for...

I can confirm that you do need to add the PowerBook3,1 line into the
<COMPATIBLE> section before the Pismo will use the os chooser script
correctly.

One thing I noticed, at least with this machine, is that the line:-

boot hd:10,\\yaboot

will fail unless I rewrite it as:-

boot hd:10,yaboot

This is the first new world machine that I have setup with Linux so I don't
know if this is right for others or if my configuration may be different.
I'm going to be upgrading :-) an iMac DV with Linux this afternoon so I'll
report back what that one does with regard to the os chooser script.

Now I'm off to try and rewrite the script so that I can choose Darwin as
well...

Regards,
       Mark Steer.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
