Message-Id: <200007201345.OAA29151@hyperion.valhalla.net>
Date: Thu, 20 Jul 2000 14:45:56 +0100
Subject: Re: problems about __cli()
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Josh Huber <huber@mclx.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thu, Jul 20, 2000,  Josh Huber wrote:
> On Thu, Jul 20, 2000 at 10:19:54AM +0100, Iain Sandoe wrote:
>>
> [snip]
>>
>> It is *vital* to make sure that there is a symlink named 'linux' in /usr/src
>> that points to your /usr/src/your-kernel-foo-bar/ because there are symlinks
>> in /usr/include that expect to use this to find the build-specific headers.
>
> A couple notes:
>
> You don't have to put your kernel in /usr/src, and you DON'T have to
> symlink /usr/src/linux to it before you build.  The symlinks (on
> broken RedHat derivatives) in /usr/include should point to the kernel
> headers that your libc was built againt, otherwise you risk breaking
> binary compatibility.

I guess I *must* have one of those broken derivatives... and it doesn't work
for me without that step...  Admittedly, this is mostly an issue between
2.2.xx and 2.4.0 - but I do have to remember to change it back between
whiles... a better way would be ?

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
