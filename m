Message-ID: <3AC49F43.94996C74@ncal.verio.com>
Date: Fri, 30 Mar 2001 06:59:15 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
Cc: Franz.Sirl-kernel@lauterbach.com,
	linuxppc-dev@lists.linuxppc.org, billfink@capu.net
Subject: Re: xine, ppc and illegal instructions
References: <200103300529.AAA24230@makai.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:
>
>         The configuration target is powerpc-*-linux, not ppc-*-linux.
> At best ppc-* could be converted to powerpc-*.  It's too bad that people
> made the wrong assumption about the configuration name, but there is not
> reason to encourage that.
>
> David

And what gods defined and documented it??? A lot of
packages are broke this way. My system has current
config scripts, config.guess/sub return powerpc-*.
The xine configure even uses them and has
a $host that is powerpc-* and without
ppc-* in the case will display an unsupported
message using $host which displays powerpc-*.
But, for some reason they use the un-canonized
$host_alias for the case statement which is ppc-*.

The bottom line is configure is a pile of
overly convoluted, underdocumented &*##. Most
package maintainers just copy from some other
already broken package and hack-n-slash till
it works on their x86 platform and leave it at
that. Getting pedantic about powerpc-* gets us
nowhere.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
