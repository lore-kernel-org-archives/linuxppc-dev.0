Date: Wed, 27 Sep 2000 12:13:12 -0700
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
From: "Jon Erick Ween" <jween@som.llu.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Olaf Hering <olh@suse.de>
CC: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5F794D8.631%jween@som.llu.edu>
In-Reply-To: <Pine.LNX.4.10.10009272015410.27656-100000@opal.biophys.uni-duesseldorf.de>
Mime-version: 1.0
Content-type: multipart/mixed;
   boundary="MS_Mac_OE_3052901595_22790_MIME_Part"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--MS_Mac_OE_3052901595_22790_MIME_Part
Content-type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Here's a copy of my XF86Config file.

Two other minor nuisances:

Since using yaboot, my console cursor has disappeared. Is this an OF or a
yaboot problem? It's very hard to navigate in vi to edit anything (.config
files for one thing) without a cursor!

Also, I can't figure out how to uninstall BootX. Throwing it away under
MacOS doesn't seem to help.

Any suggestions?

Thanks

Jon

> From: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
> Date: Wed, 27 Sep 2000 20:17:02 +0200 (CEST)
> To: Olaf Hering <olh@suse.de>
> Cc: Jon Erick Ween <jween@som.llu.edu> , linuxppc-dev@lists.linuxppc.org
> Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
>
>>> OK, I've switched from BootX to Yboot using a stable 2.2.17 kernel and the
>>> most recent XF86-4.0.1 and ati driver sources I can find. I seem to get
>>> different PCI assignments to the ATI chip on boot-up (looking at dmesg
>>> compared with using BootX) but the X-server still doesn't detect the chip
>>> with "startx" or "XFree86" and exits with a "device not found" and "no
>>> screens" error. Any further suggestions?
>>
>> There is a Modes line in the screen section, use a generic mode.
>> Don't specify a Modes section.
>
> It's probably just some error in the device section (the server doesn't
> complain about 'no valid modes found' but 'no device found'.
>
> Need to see your XF86Config's device section.
>
> Michael
>


--MS_Mac_OE_3052901595_22790_MIME_Part
Content-type: audio/wav; name="XF86Config";
 x-mac-creator="3F3F3F3F";
 x-mac-type="3F3F3F3F"
Content-disposition: attachment
Content-Transfer-Encoding: base64

U2VjdGlvbiAiU2VydmVyTGF5b3V0IgoJSWRlbnRpZmllciAgICAgIlhGcmVlODYgQ29uZmln
dXJlZCIKCVNjcmVlbiAgICAgIDAgICJTY3JlZW4wIiAwIDAKCUlucHV0RGV2aWNlICAgICJN
b3VzZTAiICJDb3JlUG9pbnRlciIKCUlucHV0RGV2aWNlICAgICJLZXlib2FyZDAiICJDb3Jl
S2V5Ym9hcmQiCkVuZFNlY3Rpb24KClNlY3Rpb24gIkZpbGVzIgpFbmRTZWN0aW9uCgpTZWN0
aW9uICJNb2R1bGUiCglMb2FkICAiR0xjb3JlIgoJTG9hZCAgImRiZSIKCUxvYWQgICJleHRt
b2QiCglMb2FkICAiZ2x4IgoJTG9hZCAgInBleDUiCglMb2FkICAicmVjb3JkIgoJTG9hZCAg
InhpZSIKRW5kU2VjdGlvbgoKU2VjdGlvbiAiSW5wdXREZXZpY2UiCglJZGVudGlmaWVyICAi
S2V5Ym9hcmQwIgoJRHJpdmVyICAgICAgImtleWJvYXJkIgoJT3B0aW9uCSJYa2JNb2RlbCIg
Ik1hY2ludG9zaCIKCU9wdGlvbgkiWGtiTGF5b3V0IgkidXMiCkVuZFNlY3Rpb24KClNlY3Rp
b24gIklucHV0RGV2aWNlIgoJSWRlbnRpZmllciAgIk1vdXNlMCIKCURyaXZlciAgICAgICJt
b3VzZSIKCU9wdGlvbiAgICAgICJQcm90b2NvbCIgImJ1c21vdXNlIgoJT3B0aW9uICAgICAg
IkRldmljZSIgIi9kZXYvYWRibW91c2UiCkVuZFNlY3Rpb24KClNlY3Rpb24gIk1vbml0b3Ii
CglJZGVudGlmaWVyICAgIk1vbml0b3IwIgoJVmVuZG9yTmFtZSAgICJBcHBsZSBDb21wdXRl
ciIKCU1vZGVsTmFtZSAgICAiTG9tYmFyZCBMQ0QiCglIb3JpelN5bmMgICAgMzAtODUKCVZl
cnRSZWZyZXNoICA2MApFbmRTZWN0aW9uCgpTZWN0aW9uICJEZXZpY2UiCgkjIyMgQXZhaWxh
YmxlIERyaXZlciBvcHRpb25zIGFyZTotCiAgICAgICAgI09wdGlvbiAgICAgIlNoYWRvd0ZC
IgogICAgICAgICNPcHRpb24gICAgICJWR0FDbG9ja3MiCglPcHRpb24gIkhXY3Vyc29yIgoJ
SWRlbnRpZmllciAgIkNhcmQwIgoJRHJpdmVyICAgICAgImF0aSIKCVZlbmRvck5hbWUgICJB
VEkiCglCb2FyZE5hbWUgICAiQVRZLExUUHJvUGFyZW50IgoJQnVzSUQgICAgICAgIlBDSTow
OjE3OjAiCkVuZFNlY3Rpb24KClNlY3Rpb24gIlNjcmVlbiIKCUlkZW50aWZpZXIgIlNjcmVl
bjAiCglEZXZpY2UgICAgICJDYXJkMCIKCU1vbml0b3IgICAgIk1vbml0b3IwIgoJRGVmYXVs
dERlcHRoCTI0CglTdWJTZWN0aW9uICJEaXNwbGF5IgoJCURlcHRoICAgICAxCgkJTW9kZXMJ
IjEwMjR4NzY4IgoJRW5kU3ViU2VjdGlvbgoJU3ViU2VjdGlvbiAiRGlzcGxheSIKCQlEZXB0
aCAgICAgNAoJCU1vZGVzCSIxMDI0eDc2OCIKCUVuZFN1YlNlY3Rpb24KCVN1YlNlY3Rpb24g
IkRpc3BsYXkiCgkJRGVwdGggICAgIDgKCQlNb2RlcwkiMTAyNHg3NjgiCglFbmRTdWJTZWN0
aW9uCglTdWJTZWN0aW9uICJEaXNwbGF5IgoJCURlcHRoICAgICAxNQoJCU1vZGVzCSIxMDI0
eDc2OCIKCUVuZFN1YlNlY3Rpb24KCVN1YlNlY3Rpb24gIkRpc3BsYXkiCgkJRGVwdGggICAg
IDE2CgkJTW9kZXMJIjEwMjR4NzY4IgoJRW5kU3ViU2VjdGlvbgoJU3ViU2VjdGlvbiAiRGlz
cGxheSIKCQlEZXB0aCAgICAgMjQKCQlNb2RlcwkiMTAyNHg3NjgiCglFbmRTdWJTZWN0aW9u
CkVuZFNlY3Rpb24KClNlY3Rpb24gIkRSSSIKRW5kU2VjdGlvbgoK

--MS_Mac_OE_3052901595_22790_MIME_Part--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
